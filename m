Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932868AbWF2JkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868AbWF2JkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbWF2JkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:40:16 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:9888
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932864AbWF2JkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:40:13 -0400
Message-Id: <44A3BC2F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 29 Jun 2006 11:40:31 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Shaohua Li" <shaohua.li@intel.com>
Cc: "Rajesh Shah" <rajesh.shah@intel.com>, "Greg KH" <greg@kroah.com>,
       "arjan" <arjan@linux.intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "Tigran Aivazian" <tigran@veritas.com>,
       "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]microcode update driver rewrite - takes 2
References: <1151376693.21189.52.camel@sli10-desk.sh.intel.com>
 <20060627060214.GA27469@kroah.com>
 <1151396103.21189.75.camel@sli10-desk.sh.intel.com>
 <1151569119.21189.106.camel@sli10-desk.sh.intel.com>
 <44A3B38F.76E4.0078.0@novell.com>
 <1151572535.21189.109.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1151572535.21189.109.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Shaohua Li <shaohua.li@intel.com> 29.06.06 11:15 >>>
>On Thu, 2006-06-29 at 11:03 +0200, Jan Beulich wrote:
>> I'm not having a problem removing the messages if the current state can be obtained
>> elsewhere.
>> 
>> Looking at the patch I see at least one problem (in more than one place) - before
>> accessing data, you should check that the relevant piece to be read is entirely within
>> range. You should not (as done at least once) rely on copy_from_user() failing - the
>> data may be readable, but out of bounds wrt. the information in the headers (or the
>> header sizes themselves).
>Can you please give me more details? I had a lot of checks there if the
>size is incorrect.

Ah, yes, I missed the sanity checking function. That seems to take care of what I thought
was missing elsewhere.

Jan
