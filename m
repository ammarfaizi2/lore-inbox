Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWGYGVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWGYGVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWGYGVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:21:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:17900 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751442AbWGYGVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:21:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=t7YVoUayu1Pf/wcLYtP0lNeWzAn3ovzUor9nO0FlE5pf+P7aRExdqrNI6zPY1+Dxoevnke1soBS4qHC+x03d7+KKMjBYlf2rvll5zTPBJOk0c54klt2xclbH/tNej95X/Z3fNVJNSp+0A6ClInorUUI6OhcCb651IEDoN0ne6nk=
Date: Tue, 25 Jul 2006 08:20:44 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: softmac possible null deref [was: Complete report of Null dereference errors in kernel 2.6.17.1]
Message-ID: <20060725062044.GA3389@leiferikson.gentoo>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1153782637.44c5536e013a4@webmail> <44C55F57.8040805@gentoo.org> <44C55F08.6060504@stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C55F08.6060504@stanford.edu>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 24, 2006 at 05:00:08PM -0700, Thomas Dillig wrote:
> At least in 2.6.17.1, the function looks as follows:
> 
> /* Create an rts/cts frame */
> 445 static u32
> 446 ieee80211softmac_rts_cts(struct ieee80211_hdr_2addr **pkt,
> 447         struct ieee80211softmac_device *mac, struct ieee80211softmac_network *net,
> 448         u32 type)
> 449 {
> 450         /* Allocate Packet */
> 451         (*pkt) = kmalloc(IEEE80211_2ADDR_LEN, GFP_ATOMIC);     452         memset(*pkt, 0, IEEE80211_2ADDR_LEN); //*pkt is not checked for 
> NULL
> 453         if((*pkt) == NULL) //*pkt is checked for NULL
> 454                 return 0;
> 455         ieee80211softmac_hdr_2addr(mac, (*pkt), type, net->bssid);
> 456         return IEEE80211_2ADDR_LEN;
> 457 }

The function does not exist anymore in my 2.6.18-rc2-gabb5a5c tree.

> The report is just trying to say that "*pkt" is dereferenced inside the call to "memset" and checked for being null one line later.

This is really odd :) One should have used kzalloc() anyway.

Hannes
