Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132084AbRAAS2M>; Mon, 1 Jan 2001 13:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132124AbRAAS2C>; Mon, 1 Jan 2001 13:28:02 -0500
Received: from [139.102.15.42] ([139.102.15.42]:59046 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S132084AbRAAS1m>; Mon, 1 Jan 2001 13:27:42 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: linux-kernel@vger.kernel.org
Date: Mon, 1 Jan 2001 12:56:27 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [PATCH] Remove compile warnings from 2.4.0-prerelease1-ac1
Reply-to: richbaum@acm.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Message-ID: <3A507E7B.19898.33134B@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that removes warnings about depecrated use of 
labels at the end of compound statements and warnings about 
extra tokens at the end of #undef directives when using the 
20001225 gcc snapshot.  Could you please look this over for 
possible inclusion in 2.4.0 or 2.4.0-prerelease1-ac2?  Some 
warnings I had with prerelease1 were fixed in ac1 so I did similar 
fixes for the warnings I still had.

Thanks.
Rich


diff -urN linux/drivers/acpi/hardware/hwcpu32.c rb/drivers/acpi/hardware/hwcpu32.c
--- linux/drivers/acpi/hardware/hwcpu32.c	Sun Dec 31 19:19:05 2000
+++ rb/drivers/acpi/hardware/hwcpu32.c	Mon Jan  1 08:48:20 2001
@@ -708,4 +708,4 @@
 	return;
 }
 
- 
\ No newline at end of file
+
diff -urN linux/drivers/acpi/namespace/nsxfobj.c rb/drivers/acpi/namespace/nsxfobj.c
--- linux/drivers/acpi/namespace/nsxfobj.c	Sun Dec 31 19:19:05 2000
+++ rb/drivers/acpi/namespace/nsxfobj.c	Mon Jan  1 11:32:39 2001
@@ -694,4 +694,5 @@
 	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
 
 	return (status);
-}
\ No newline at end of file
+}
+
diff -urN linux/drivers/scsi/sym53c8xx.c rb/drivers/scsi/sym53c8xx.c
--- linux/drivers/scsi/sym53c8xx.c	Tue Sep 19 10:31:53 2000
+++ rb/drivers/scsi/sym53c8xx.c	Mon Jan  1 11:30:30 2001
@@ -11862,7 +11862,7 @@
 out_clrack:
 	OUTL (nc_dsp, NCB_SCRIPT_PHYS (np, clrack));
 	return;
-out_stuck:
+out_stuck:;
 }
 
 
@@ -14830,10 +14830,10 @@
 	return retv;
 }
 
-#undef SET_BIT 0
-#undef CLR_BIT 1
-#undef SET_CLK 2
-#undef CLR_CLK 3
+#undef SET_BIT /* 0 */
+#undef CLR_BIT /* 1 */
+#undef SET_CLK /* 2 */
+#undef CLR_CLK /* 3 */
 
 /*
  *  Try reading Symbios NVRAM.
diff -urN linux/drivers/sound/mpu401.c rb/drivers/sound/mpu401.c
--- linux/drivers/sound/mpu401.c	Sat Nov 11 21:32:01 2000
+++ rb/drivers/sound/mpu401.c	Mon Jan  1 11:28:48 2001
@@ -1449,7 +1449,7 @@
 			}
 			break;
 
-		default:
+		default:;
 	}
 	return TIMER_NOT_ARMED;
 }
@@ -1559,7 +1559,7 @@
 			setup_metronome(midi_dev);
 			return 0;
 
-		default:
+		default:;
 	}
 	return -EINVAL;
 }
diff -urN linux/drivers/sound/sb_ess.c rb/drivers/sound/sb_ess.c
--- linux/drivers/sound/sb_ess.c	Fri Aug 11 10:26:43 2000
+++ rb/drivers/sound/sb_ess.c	Mon Jan  1 11:27:14 2001
@@ -770,7 +770,7 @@
 		case IMODE_INIT:
 			break;
 
-		default:
+		default:;
 			/* printk(KERN_WARN "ESS: Unexpected interrupt\n"); */
 	}
 }
diff -urN linux/drivers/sound/sequencer.c rb/drivers/sound/sequencer.c
--- linux/drivers/sound/sequencer.c	Mon Sep 25 14:32:54 2000
+++ rb/drivers/sound/sequencer.c	Mon Jan  1 11:26:19 2001
@@ -511,7 +511,7 @@
 			synth_devs[dev]->aftertouch(dev, voice, parm);
 			break;
 
-		default:
+		default:;
 	}
 #undef dev
 #undef cmd
@@ -614,7 +614,7 @@
 				synth_devs[dev]->bender(dev, chn, w14);
 			break;
 
-		default:
+		default:;
 	}
 }
 
@@ -684,7 +684,7 @@
 			}
 			break;
 
-		default:
+		default:;
 	}
 
 	return TIMER_NOT_ARMED;
@@ -701,7 +701,7 @@
 			DMAbuf_start_devices(parm);
 			break;
 
-		default:
+		default:;
 	}
 }
 
@@ -859,7 +859,7 @@
 			seq_sysex_message(q);
 			break;
 
-		default:
+		default:;
 	}
 	return 0;
 }
diff -urN linux/drivers/sound/sound_timer.c rb/drivers/sound/sound_timer.c
--- linux/drivers/sound/sound_timer.c	Sun Oct  1 22:35:16 2000
+++ rb/drivers/sound/sound_timer.c	Mon Jan  1 11:26:42 2001
@@ -165,7 +165,7 @@
 			seq_copy_to_input(event, 8);
 			break;
 
-		default:
+		default:;
 	}
 	return TIMER_NOT_ARMED;
 }
diff -urN linux/fs/isofs/inode.c rb/fs/isofs/inode.c
--- linux/fs/isofs/inode.c	Mon Jan  1 08:10:13 2001
+++ rb/fs/isofs/inode.c	Mon Jan  1 11:32:09 2001
@@ -1264,7 +1264,7 @@
 	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
 		printk(KERN_WARNING "Multi-volume CD somehow got mounted.\n");
 	} else
-#endif IGNORE_WRONG_MULTI_VOLUME_SPECS
+#endif /*IGNORE_WRONG_MULTI_VOLUME_SPECS */
 	{
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = &generic_ro_fops;
diff -urN linux/net/ipv4/arp.c rb/net/ipv4/arp.c
--- linux/net/ipv4/arp.c	Tue Oct 10 12:33:52 2000
+++ rb/net/ipv4/arp.c	Mon Jan  1 11:31:30 2001
@@ -292,7 +292,7 @@
 			neigh->output = neigh->ops->output;
 			return 0;
 #endif
-		}
+		;}
 #endif
 		if (neigh->type == RTN_MULTICAST) {
 			neigh->nud_state = NUD_NOARP;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
