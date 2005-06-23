Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVFWQXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVFWQXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 12:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVFWQXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 12:23:33 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:18948 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262603AbVFWQX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 12:23:29 -0400
Date: Thu, 23 Jun 2005 18:23:25 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Pekka Enberg <penberg@gmail.com>, Alexander Zarochentcev <zam@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050623162325.GA21971@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Vladimir Saveliev <vs@namesys.com>,
	Pekka Enberg <penberg@gmail.com>,
	Alexander Zarochentcev <zam@namesys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com> <84144f0205062223226d560e41@mail.gmail.com> <42BA67C9.7060604@namesys.com> <1119543302.4115.141.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119543302.4115.141.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 08:15:03PM +0400, Vladimir Saveliev wrote:
> Pekka, would you prefer something like:
> 
> reiser4_fill_super()
> {
>     if (init_a() == 0) {
> 	if (init_b() == 0) {
> 	    if (init_c() == 0) {
> 		if (init_last() == 0)
> 		    return 0;
> 		else {
> 		    done_c();
> 		    done_b();
> 		    done_a();
> 		}
> 	    } else {
> 		done_b();
> 		done_a();
> 	    }
> 	} else {
> 	    done_a();
> 	}
>     }
> }

No, I think he means the traditional:

reiser4_fill_super()
{
   if (init_a())
     goto failed_a;
   if (init_b())
     goto failed_b;
   if (init_c())
     goto failed_c;
   if (init_last())
     goto failed_last;
   return 0;

 failed_last:
   done_c();
 failed_c:
   done_b();
 failed_b:
   done_a();
 failed_a:
   return 1;
}
