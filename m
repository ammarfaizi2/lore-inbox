Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVHKGz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVHKGz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 02:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVHKGz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 02:55:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932075AbVHKGz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 02:55:57 -0400
Subject: Re: [PATCH 00/14] GFS
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
In-Reply-To: <20050811060602.GA12438@redhat.com>
References: <20050802071828.GA11217@redhat.com>
	 <1122968724.3247.22.camel@laptopd505.fenrus.org>
	 <20050811060602.GA12438@redhat.com>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 08:55:49 +0200
Message-Id: <1123743349.3201.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 14:06 +0800, David Teigland wrote:
> On Tue, Aug 02, 2005 at 09:45:24AM +0200, Arjan van de Ven wrote:
> 
> > * +	if (create)
> > +		down_write(&ip->i_rw_mutex);
> > +	else
> > +		down_read(&ip->i_rw_mutex);
> > 
> > why do you use a rwsem and not a regular semaphore? You are aware that
> > rwsems are far more expensive than regular ones right?  How skewed is
> > the read/write ratio?
> 
> Rough tests show around 4/1, that high or low?

that's quite borderline; if it was my code I'd not use a rwsem for that
ratio (my own rule of thumb, based on not a lot other than gut feeling)
is a 10/1 ratio at minimum... but it's not so low that it screams for
removing it. However.... it might well make your code a lot simpler so
it might still be worth simplifying.


