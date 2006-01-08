Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752597AbWAHFdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbWAHFdN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbWAHFdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:33:13 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:50736 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752596AbWAHFdM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:33:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WvQnic1UuPYldvAUahUgOkxYy7aHKS6POjf9ZTf0wB1K5XWD1AQL/tV8Rz9xn77poH3osgPO/ZsXV2zcDRib72e5/Tuq7+BYYScr51LWJNFAZ4PhhI6RCNX2ldxzaUDFmdb6vaDBNkPR42okyh07u+Sa7YrBQPLkClfX+5iZIAg=
Message-ID: <4807377b0601072133r4f079226r11001fae500c9569@mail.gmail.com>
Date: Sat, 7 Jan 2006 21:33:10 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: "ODonnell, Michael" <Michael.ODonnell@stratus.com>
Subject: Re: (2nd try) [PATCH] corruption during e100 MDI register access
Cc: bonding-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       NetDEV list <netdev@vger.kernel.org>
In-Reply-To: <92952AEF1F064042B6EF2522E0EEF43703225312@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <92952AEF1F064042B6EF2522E0EEF43703225312@EXNA.corp.stratus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, ODonnell, Michael <Michael.ODonnell@stratus.com> wrote:
>  [ 2nd transmission.  Microsoft mailer "helpfully"
>   reformatted the patch in the last one... :-(    ]
>
> Greetings,
>
> We have identified two related bugs in the e100 driver and we request
> that they be repaired in the official Intel version of the driver.
>
> Both bugs are related to manipulation of the MDI control register.
>
> The first problem is that the Ready bit is being ignored when
> writing to the Control register; we noticed this because the Linux
> bonding driver would occasionally come to the spurious conclusion
> that the link was down when querying Link State.  It turned out
> that by failing to wait for a previous command to complete it was
> selecting what was essentially a random register in the MDI register
> set.  When we added code that waits for the Ready bit (as shown in
> the patch file below) all such problems ceased.

damn, you know I had seen this on one machine only, and the machine
had other problems, so i thought it wasn't e100.  I can't quite figure
out why we haven't seen this more often given how long the bug appears
to have existed.

> The second problem is that, although access to the MDI registers
> involves multiple steps which must not be intermixed, nothing was
> defending against two or more threads attempting simultaneous access.
> The most obvious situation where such interference could occur
> involves the watchdog versus ioctl paths, but there are probably
> others, so we recommend the locking shown in our patch file.

Agreed, but once again I am simply amazed this has been there so long.

I think these are both good patches and I'll ack this and absorb it
for our next release.  It will be a bit before its completely through
our process but its okay with me if this goes into the kernel now.

Jesse
