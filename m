Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWEMRRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWEMRRc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 13:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWEMRRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 13:17:32 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:61902 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750764AbWEMRRc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 13:17:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S3RFSS4pO1TH7NElevOQ82LYrlk2dng7Q3o3bjSC4a8BgzLutogivFxR8m8Ibi8XKkJG5TZ24UWvjgxs102Fr5WjBqolrk57V2HQHpS+Vx46t/k2W+LvxV/YAmUkcnRaoeQocSzqvK4mK9PuvtC+FrSF4T36+sEuAOvGKgSJQyQ=
Message-ID: <2151339d0605131017v6fdda8edt334f43fb62e3f253@mail.gmail.com>
Date: Sat, 13 May 2006 10:17:31 -0700
From: "Nathan Becker" <nathanbecker@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200605122132.41410.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com>
	 <200605061232.52303.david-b@pacbell.net>
	 <2151339d0605092237m4ef4e835k16b8c779f6ad7046@mail.gmail.com>
	 <200605122132.41410.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch.  However, did you not get my very last message?
Checking back through my mail logs, I think it might not have been
delivered.

After claiming that the dma mask fixed the problem, I quickly
discovered that the dma was not what did it.  Thus the patch you sent
does not work.

But, here is what does: If I rmmod ehci_hcd and then modprobe
ehci_hcd, it works, and I get full USB 2.0 speed.  There must be
something happening in the clean-up code of the the ehci_hcd  that
fixes whatever conflict I'm having.  When I originally made that patch
and then reloaded the ehci_hcd module to test it, I mistakenly thought
that it was the patch that was fixing the problem.  I should have
tested more thoroughly before sending the e-mail, but I got very
excited.  Sorry about that.  After several days of using the
rmmod/modprobe workaround, I do feel confident that it is a legitimate
fix.
