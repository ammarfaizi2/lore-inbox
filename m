Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWB1FUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWB1FUH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 00:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWB1FUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 00:20:06 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:61892 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751797AbWB1FUF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 00:20:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j3jGlaP0IXQr0IbULB282DaKfzAT+jWjApJ8m7tJPw3BAJhr5MtNf6ocsLT/U7ziLQ6jZZwSn8Bw0C/KbW7u7qh8fUd23mXjYDAzQMZWFOE6g30bSXuH+zCay/59L+WEprOR0ExOrpCpHgbh1qn6TYEgdregs+L66SZyNAJ4C8o=
Message-ID: <aec7e5c30602272120l54a3e8c9k2db51a1c86823f7b@mail.gmail.com>
Date: Tue, 28 Feb 2006 14:20:03 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "John Richard Moser" <nigelenki@comcast.net>
Subject: Re: Memory compression (again). . help?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4403C30A.6070704@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4403A14D.4050303@comcast.net> <4403C30A.6070704@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/06, John Richard Moser <nigelenki@comcast.net> wrote:
> Hmm, I can't see where the kernel checks to see which pages are least
> used. . . . anyone good with the VM can point me in the right direction?

The page reclaim code responsible for shrinking the LRUs code be found
in mm/vmscan.c. That file contains a lot of code, my recommendation to
you is to have a look at shrink_zone() which is responsible for
rotating and shrinking the active and inactive lists.

Also, If you want to compress pages that normally would be swapped
out, then I recommend you to have a look at the functions in
mm/swap_state.c and see how swap space gets allocated and freed.

If you need to know more about the Linux VM then I recommend you to
buy the excellent book "Understanding the Linux Virtual Memory
Manager" written by Mel Gorman, ISBN 0-13-145348-3. My copy of that
book covers Linux-2.4 and has some comments about 2.6 too.

/ magnus
