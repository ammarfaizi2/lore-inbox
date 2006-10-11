Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161387AbWJKVFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161387AbWJKVFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161400AbWJKVFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:05:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:52382 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161387AbWJKVFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:05:24 -0400
Date: Wed, 11 Oct 2006 14:04:42 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/67] ALSA: Fix initiailization of user-space controls
Message-ID: <20061011210442.GP16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-fix-initiailization-of-user-space-controls.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

ALSA: Fix initiailization of user-space controls

Fix an assertion when accessing a user-defined control due to lack of
initialization (appears only when CONFIG_SND_DEBUg is enabled).

  ALSA sound/core/control.c:660: BUG? (info->access == 0)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/core/control.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.orig/sound/core/control.c
+++ linux-2.6.18/sound/core/control.c
@@ -997,6 +997,7 @@ static int snd_ctl_elem_add(struct snd_c
 	if (ue == NULL)
 		return -ENOMEM;
 	ue->info = *info;
+	ue->info.access = 0;
 	ue->elem_data = (char *)ue + sizeof(*ue);
 	ue->elem_data_size = private_size;
 	kctl.private_free = snd_ctl_elem_user_free;

--
