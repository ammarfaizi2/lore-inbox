Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRJGOFU>; Sun, 7 Oct 2001 10:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276329AbRJGOFK>; Sun, 7 Oct 2001 10:05:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34565 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274034AbRJGOEt>; Sun, 7 Oct 2001 10:04:49 -0400
Subject: Re: Dell Latitude C600 suspend problem
To: Tim.Stadelmann@physics.ox.ac.uk (Tim Stadelmann)
Date: Sun, 7 Oct 2001 15:10:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011007115712.A4357@univn10.univ.ox.ac.uk> from "Tim Stadelmann" at Oct 07, 2001 11:57:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qEdC-0005tB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A closer investigation revealed that the patch meant to correct a
> problem with the internal ps2 pointing device on suspend is at fault.
> Commenting out the entry in arch/i386/kernel/dmi_scan.c that triggers
> the activation of this logic for the C600 allows the machine to
> suspend normally.

The change doesn't affect the suspend. What it deals with is the resume
side. When the C600 resumes it doesn't always restore the keyboard/mouse
state.

The actual code it runs is pckbd_pm_resume() (pc_keyb.c) so you might want
to see if that is actually triggering and where it hangs during the resume
Its possible it broke across the merge due to other keyb changes
