Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVAEB6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVAEB6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVAEB6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:58:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47302 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262086AbVAEB47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:56:59 -0500
Date: Tue, 4 Jan 2005 20:56:10 -0500
From: Dave Jones <davej@redhat.com>
To: Matze Braun <MatzeBraun@gmx.de>, Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: ALSA Maestro driver spinlock bug.
Message-ID: <20050105015610.GF24231@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matze Braun <MatzeBraun@gmx.de>, Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of our Fedora users reported a bug that showed up
with spinlock debugging enabled.

sound/pci/es1968.c: es1968_measure_clock()

At line 1811, we acquire &chip->reg_lock
and then call snd_es1968_bob_inc(), which
calls snd_es1968_bob_start(), which tries to
acquire the same lock at line 885.

It barfs as a result.  Is it safe to move
the snd_es1968_bob_inc() call before we
take the lock ?

		Dave

