Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263554AbRFAOxE>; Fri, 1 Jun 2001 10:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263559AbRFAOwz>; Fri, 1 Jun 2001 10:52:55 -0400
Received: from mailgate.indstate.edu ([139.102.15.118]:35045 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S263554AbRFAOwm>; Fri, 1 Jun 2001 10:52:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rich Baum <richbaum@acm.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Warning fixes for 2.4.5-ac6
Date: Fri, 1 Jun 2001 09:42:30 -0500
X-Mailer: KMail [version 1.2.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <928150C619F@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that fixes warnings in 2.4.5-ac6.  The patch for the Makefile 
removes warnings about the use of trigraphs.  To me, this seems better than 
having to put backslashes before a question mark when you are printing out 2 
or more in a row.  The fpu_trig.c patch is mentioned in the log for 
2.4.4-ac18 but was not included.  Let me know if you have any problems.

Rich


diff -urN -X dontdiff linux/Makefile rb/Makefile
--- linux/Makefile	Fri Jun  1 08:47:51 2001
+++ rb/Makefile	Fri Jun  1 08:48:00 2001
@@ -94,7 +94,7 @@
 
 CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
-CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strict-aliasing
+CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fomit-frame-pointer -fno-strict-aliasing
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
 #
diff -urN -X dontdiff linux/arch/i386/math-emu/fpu_trig.c 
rb/arch/i386/math-emu/fpu_trig.c
--- linux/arch/i386/math-emu/fpu_trig.c	Fri Apr  6 12:42:47 2001
+++ rb/arch/i386/math-emu/fpu_trig.c	Wed May 30 17:47:15 2001
@@ -1543,6 +1543,7 @@
 	  EXCEPTION(EX_INTERNAL | 0x116);
 	  return;
 #endif /* PARANOID */
+	  break;
 	}
     }
   else if ( (st0_tag == TAG_Valid) || (st0_tag == TW_Denormal) )
diff -urN -X dontdiff linux/drivers/atm/fore200e.c rb/drivers/atm/fore200e.c
--- linux/drivers/atm/fore200e.c	Tue May 29 17:46:23 2001
+++ rb/drivers/atm/fore200e.c	Wed May 30 17:47:15 2001
@@ -439,6 +439,7 @@
 
     case FORE200E_STATE_BLANK:
 	/* nothing to do for that state */
+	break;
     }
 }
 
diff -urN -X dontdiff linux/drivers/media/video/tuner.c 
rb/drivers/media/video/tuner.c
--- linux/drivers/media/video/tuner.c	Mon Feb 19 17:43:36 2001
+++ rb/drivers/media/video/tuner.c	Wed May 30 17:47:15 2001
@@ -558,6 +558,7 @@
 #endif
 	default:
 		/* nothing */
+		break;
 	}
 	
 	return 0;
diff -urN -X dontdiff linux/drivers/media/video/zr36067.c 
rb/drivers/media/video/zr36067.c
--- linux/drivers/media/video/zr36067.c	Sat May 26 18:58:30 2001
+++ rb/drivers/media/video/zr36067.c	Wed May 30 17:26:26 2001
@@ -1411,6 +1411,7 @@
 		post_office_write(zr, 3, 0, 0);
 		udelay(2);
 	default:
+		break;
 	}
 	return 0;
 }
diff -urN -X dontdiff linux/drivers/net/wan/hdlc.c rb/drivers/net/wan/hdlc.c
--- linux/drivers/net/wan/hdlc.c	Wed Apr 18 16:40:07 2001
+++ rb/drivers/net/wan/hdlc.c	Thu May 31 10:05:22 2001
@@ -1080,9 +1080,10 @@
 					       result);
 				}
 			}
-			break;
 
-		default:		/* to be defined */
+		default:
+			/* to be defined */
+			break;
 		}
 
 		dev_kfree_skb(skb);
diff -urN -X dontdiff linux/drivers/net/wan/sdla_fr.c 
rb/drivers/net/wan/sdla_fr.c
--- linux/drivers/net/wan/sdla_fr.c	Fri Apr 20 13:54:22 2001
+++ rb/drivers/net/wan/sdla_fr.c	Thu May 31 10:05:50 2001
@@ -4434,8 +4434,8 @@
 		chan->inarp = INARP_CONFIGURED;
 		trigger_fr_poll(dev);
 		
-		break;
-	default:  // ARP's and RARP's -- Shouldn't happen.
+	default:  
+		break; // ARP's and RARP's -- Shouldn't happen.
 	}
 
 	return 0;	
diff -urN -X dontdiff linux/drivers/scsi/sym53c8xx.c 
rb/drivers/scsi/sym53c8xx.c
--- linux/drivers/scsi/sym53c8xx.c	Sat May 26 18:58:35 2001
+++ rb/drivers/scsi/sym53c8xx.c	Thu May 31 10:06:23 2001
@@ -11571,8 +11571,8 @@
 	return;
 out_clrack:
 	OUTL_DSP (NCB_SCRIPT_PHYS (np, clrack));
-	return;
 out_stuck:
+	return;
 }
 
 
diff -urN -X dontdiff linux/drivers/sound/gus_wave.c 
rb/drivers/sound/gus_wave.c
--- linux/drivers/sound/gus_wave.c	Sun Nov 12 23:35:35 2000
+++ rb/drivers/sound/gus_wave.c	Wed May 30 17:47:15 2001
@@ -2102,6 +2102,7 @@
 			break;
 
 		default:
+			break;
 	}
 }
 
@@ -3282,6 +3283,7 @@
 		break;
 
 		default:
+			break;
 	}
 	restore_flags(flags);
 }
@@ -3423,6 +3425,7 @@
 				break;
 
 			default:
+				break;
 	}
 	status = gus_look8(0x49);	/*
 					 * Get Sampling IRQ Status
diff -urN -X dontdiff linux/drivers/sound/pss.c rb/drivers/sound/pss.c
--- linux/drivers/sound/pss.c	Sun Feb  4 13:05:29 2001
+++ rb/drivers/sound/pss.c	Wed May 30 17:47:15 2001
@@ -766,6 +766,7 @@
 			break;
 
 		default:
+			break;
 	}
 	return 0;
 }
diff -urN -X dontdiff linux/drivers/sound/wf_midi.c rb/drivers/sound/wf_midi.c
--- linux/drivers/sound/wf_midi.c	Fri Jun  1 08:47:52 2001
+++ rb/drivers/sound/wf_midi.c	Fri Jun  1 08:48:02 2001
@@ -231,6 +231,7 @@
 				break;
 		    
 			default:
+				break;
 			}
 		} else {
 			mi->m_prev_status = midic;
diff -urN -X dontdiff linux/drivers/sound/ymfpci.c rb/drivers/sound/ymfpci.c
--- linux/drivers/sound/ymfpci.c	Sat May 26 18:58:35 2001
+++ rb/drivers/sound/ymfpci.c	Wed May 30 17:47:15 2001
@@ -1856,6 +1856,7 @@
 		 * for instance we get SNDCTL_TMR_CONTINUE here.
 		 * XXX Is there sound_generic_ioctl() around?
 		 */
+		 break;
 	}
 	return -ENOTTY;
 }
diff -urN -X dontdiff linux/fs/ntfs/fs.c rb/fs/ntfs/fs.c
--- linux/fs/ntfs/fs.c	Sat May 26 18:58:39 2001
+++ rb/fs/ntfs/fs.c	Wed May 30 17:27:52 2001
@@ -836,7 +836,7 @@
 			goto unl_out;
 		} /* Do the default for ngt_full. */
 	default:
-		/* Nothing. Just clear the inode and exit. */
+		break;	/* Nothing. Just clear the inode and exit. */
 	}
 	ntfs_clear_inode(&inode->u.ntfs_i);
 unl_out:
diff -urN -X dontdiff linux/fs/sysv/inode.c rb/fs/sysv/inode.c
--- linux/fs/sysv/inode.c	Sat May 26 18:58:40 2001
+++ rb/fs/sysv/inode.c	Wed May 30 17:25:01 2001
@@ -442,7 +442,7 @@
 			brelse(bh);
 			printk("SysV FS: cannot read superblock in %d byte mode\n", 
sb->sv_block_size);
 			goto failed;
-		superblock_ok:
+		superblock_ok:;
 		}
 	} else {
 		/* Switch to 512 block size. Unfortunately, we have to
diff -urN -X dontdiff linux/net/ipv4/netfilter/ipfwadm_core.c 
rb/net/ipv4/netfilter/ipfwadm_core.c
--- linux/net/ipv4/netfilter/ipfwadm_core.c	Fri Aug  4 20:18:49 2000
+++ rb/net/ipv4/netfilter/ipfwadm_core.c	Wed May 30 17:47:15 2001
@@ -515,7 +515,7 @@
 			}
 			continue;	/* Mismatch */
 
-		ifa_ok:
+		ifa_ok:;
 		}
 
 		/*
diff -urN -X dontdiff linux/net/ipv4/netfilter/ipt_REJECT.c 
rb/net/ipv4/netfilter/ipt_REJECT.c
--- linux/net/ipv4/netfilter/ipt_REJECT.c	Fri Apr 27 16:15:01 2001
+++ rb/net/ipv4/netfilter/ipt_REJECT.c	Thu May 31 10:08:59 2001
@@ -309,9 +309,9 @@
     		break;
 	case IPT_TCP_RESET:
 		send_reset(*pskb, hooknum == NF_IP_LOCAL_IN);
-		break;
 	case IPT_ICMP_ECHOREPLY:
 		/* Doesn't happen. */
+		break;
 	}
 
 	return NF_DROP;
diff -urN -X dontdiff linux/net/khttpd/security.h rb/net/khttpd/security.h
--- linux/net/khttpd/security.h	Wed Aug 18 11:45:10 1999
+++ rb/net/khttpd/security.h	Wed May 30 17:25:31 2001
@@ -9,4 +9,5 @@
 	char value[32-sizeof(void*)];  /* fill 1 cache-line */
 };
 
-#endif
\ No newline at end of file
+#endif
+
diff -urN -X dontdiff linux/net/sched/sch_cbq.c rb/net/sched/sch_cbq.c
--- linux/net/sched/sch_cbq.c	Sun Mar 25 21:14:25 2001
+++ rb/net/sched/sch_cbq.c	Wed May 30 17:25:52 2001
@@ -282,6 +282,7 @@
 		case TC_POLICE_SHOT:
 			return NULL;
 		default:
+			break;
 		}
 #endif
 		if (cl->level == 0)
