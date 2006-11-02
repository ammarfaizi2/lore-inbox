Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWKBSap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWKBSap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbWKBSap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:30:45 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:18454 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751935AbWKBSao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:30:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d5AiMffU6p7Gp7DrD4ryIZD6ZlozzS4ISne9vb+mhFo20UoZ+g7OW5mMeH8YdRvZ7CENBfiwJh880kYhl71hqWGBC+BIMSp/v5BHtGRd76UK3wgp4uVIsgeVae8unYOd8sAHBXMOiW+Ci4l40nuMcFdfg+OHis8tN0f8wZi3iaU=
Message-ID: <b5def3a40611021030s1b73daa1k2055e5f4373fa746@mail.gmail.com>
Date: Thu, 2 Nov 2006 13:30:34 -0500
From: "Ivan Matveich" <ivan.matveich@gmail.com>
To: "Dan Williams" <dcbw@redhat.com>
Subject: Re: [airo.c bug] Couldn't allocate RX FID / Max tries exceeded when issueing command
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, breed@users.sourceforge.net,
       achirica@users.sourceforge.net, jt@hpl.hp.com, fabrice@bellet.info
In-Reply-To: <1162483971.2646.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b5def3a40611011914v59ecd4c3xb6965591524aa11@mail.gmail.com>
	 <1162483971.2646.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/06, Dan Williams <dcbw@redhat.com> wrote:
> It appears that the driver cannot talk to your card; see the "max tries
> exceeded when issueing command".  Did this card work previously with a
> kernel?  Can narrow down which kernels have problems and which don't?

It spontaneously stopped working about a week after I bought the
laptop and installed Linux. I tried kernel 2.6.12 and it had the same
problem. (Let me know if you'd like me to try a specific version.)

I'm hoping that the card has simply got itself into some kind of
invalid state, and not failed altogether.

> It's a bit hard to figure out what firmware you have because the driver
> can't talk to the card; can you boot under Windows and determine that
> using the Cisco wireless utility?  You also need to flash the card under
> Windows, not Linux, ideally to a version of firmware greater than
> 5.60.08.

I haven't run Windows in many years, so that's problematic. What's the
most straightforward way to boot into a Windows environment sufficient
to run the Cisco wireless utility?

> reloading the driver (rmmod airo; modprobe airo) should reset the card.

Yeah, it unfortunately doesn't help. (Nor does rebooting or resetting
the bios.) I noticed a suspiciously relevant commit in the airo.c git
log:

    [wireless airo] reset card in init

    without this patch after an rmmod, modprobe the card won't work anymore
    until the next reboot.

    This patch seem safe to apply for all cards as the bsd driver already do
    that.

    I had to add a timeout because strange things happen (issuecommand will
    fail) if the card is already reseted (after a reboot).

    PS : it seems there are missing reset when leaving monitor mode...

    Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

and that makes me wonder if there might be some kind of subtle bug in
the card initialization sequence that manifests itself with my
particular card/firmware.

I think I'll burn a freebsd livecd today and see if their kernel works.
