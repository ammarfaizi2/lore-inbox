Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267381AbTAGNIH>; Tue, 7 Jan 2003 08:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTAGNIH>; Tue, 7 Jan 2003 08:08:07 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:5595 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S267381AbTAGNIF>; Tue, 7 Jan 2003 08:08:05 -0500
Date: Tue, 7 Jan 2003 15:16:39 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: "enumeration value not handled in switch" in pcm_native.c
Message-ID: <20030107131639.GK25540@alhambra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound/core/pcm_native.c has a few switch statements where
SNDRV_PCM_STATE_LAST is not handled. Add a 'default' case which
perserves the current semantics but silences the compiler up. Patch is
against 2.5.54-bk. 

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.976   -> 1.977  
#	sound/core/pcm_native.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	mulix@alhambra.mulix.org	1.977
# fix 'enumeration value not handled in switch' warning
# --------------------------------------------
#
diff -Nru a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c	Tue Jan  7 14:24:06 2003
+++ b/sound/core/pcm_native.c	Tue Jan  7 14:24:06 2003
@@ -1081,6 +1081,8 @@
 		/* Fall through */
 	case SNDRV_PCM_STATE_SETUP:
 		goto _end;
+	default: 
+		break; 
 	}
 
 	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING) {
@@ -1183,6 +1185,8 @@
 			spin_lock_irq(&runtime->lock);
 		}
 		goto _xrun_recovery;
+	default:
+		break; 
 	}
 	runtime->control->appl_ptr = runtime->status->hw_ptr;
        _end:
@@ -1236,6 +1240,8 @@
 			spin_lock_irq(&runtime->lock);
 		}
 		goto _xrun_recovery;
+	default: 
+		break; 
 	}
        _end:
 	spin_unlock_irq(&runtime->lock);
@@ -1278,6 +1284,8 @@
 	case SNDRV_PCM_STATE_XRUN:
 		snd_pcm_change_state(substream, SNDRV_PCM_STATE_SETUP);
 		break;
+	default: 
+		break; 
 	}
 	runtime->control->appl_ptr = runtime->status->hw_ptr;
        _end: 

-- 
Muli Ben-Yehuda

my opinions may seem crazy. But they all make sense. Insane sense, but
sense nontheless. -- Shlomi Fish on #offtopic.

