Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSLHKSa>; Sun, 8 Dec 2002 05:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbSLHKSa>; Sun, 8 Dec 2002 05:18:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38415 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265277AbSLHKS3>; Sun, 8 Dec 2002 05:18:29 -0500
Date: Sun, 8 Dec 2002 10:26:03 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: 2.5.50: strange /devices/bus/pci/drivers/EMU10K1/Audigy entry - file is half there?
Message-ID: <20021208102603.B30105@flint.arm.linux.org.uk>
Reply-To: Jurriaan <thunder7@xs4all.nl>, alsa-devel@alsa-project.org,
       Russell King <rmk@arm.linux.org.uk>
Mail-Followup-To: Jurriaan <thunder7@xs4all.nl>,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20021208055155.GB2712@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021208055155.GB2712@middle.of.nowhere>; from thunder7@xs4all.nl on Sun, Dec 08, 2002 at 06:51:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 06:51:55AM +0100, Jurriaan wrote:
> INTEL :ls
> 8139too  EMU10K1/Audigy  HPT366 IDE  Promise Old IDE  VIA IDE  agpgart  matroxfb  parport_pc  serial
> INTEL :ls -l
> ls: EMU10K1/Audigy: No such file or directory

Someone has a "/" in their device name string (sound/pci/emu10k1/emu10k1.c):

static struct pci_driver driver = {
        .name = "EMU10K1/Audigy",
        .id_table = snd_emu10k1_ids,
        .probe = snd_card_emu10k1_probe,
        .remove = __devexit_p(snd_card_emu10k1_remove),
};

and "/" is, of course, the path separator.  Change the "/" to "_" or some
other character and it'll work.

(also copied to the alsa folk - alsa-devel@alsa-project.org.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

