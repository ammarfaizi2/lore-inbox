Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263495AbREYCmA>; Thu, 24 May 2001 22:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263494AbREYCll>; Thu, 24 May 2001 22:41:41 -0400
Received: from mailgate.indstate.edu ([139.102.15.118]:54473 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S263493AbREYCl2>; Thu, 24 May 2001 22:41:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rich Baum <richbaum@acm.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] warning fixes for 2.4.5pre5
Date: Thu, 24 May 2001 21:40:11 -0500
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <873E21525C8@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that fixes warnings when using gcc 3.0 snapshots to compile 
the kernel.  Most of these warnings are for labels at the end of compound 
statements and extra tokens at the end of #endifs.  The patch for 
linux/drivers/usb/pwc-uncompress.c adds includes to fix warnings where 
kmalloc(), kfree(), and  EXPORT_SYMBOL_NONVERS() implicity declared.

This patch has been tested and the code does compile. 

Rich

diff -urN -X /linux/dontdiff linux/arch/i386/math-emu/fpu_trig.c 
rb/arch/i386/math-emu/fpu_trig.c
--- linux/arch/i386/math-emu/fpu_trig.c	Fri Apr  6 12:42:47 2001
+++ rb/arch/i386/math-emu/fpu_trig.c	Tue May 22 16:44:57 2001
@@ -1543,6 +1543,7 @@
 	  EXCEPTION(EX_INTERNAL | 0x116);
 	  return;
 #endif /* PARANOID */
+	  return;	
 	}
     }
   else if ( (st0_tag == TAG_Valid) || (st0_tag == TW_Denormal) )
diff -urN -X /linux/dontdiff linux/drivers/atm/fore200e.c 
rb/drivers/atm/fore200e.c
--- linux/drivers/atm/fore200e.c	Fri Feb  9 14:30:22 2001
+++ rb/drivers/atm/fore200e.c	Tue May 22 16:44:57 2001
@@ -439,6 +439,7 @@
 
     case FORE200E_STATE_BLANK:
 	/* nothing to do for that state */
+	break;
     }
 }
 
diff -urN -X /linux/dontdiff linux/drivers/cdrom/sbpcd.c 
rb/drivers/cdrom/sbpcd.c
--- linux/drivers/cdrom/sbpcd.c	Fri Apr  6 12:42:55 2001
+++ rb/drivers/cdrom/sbpcd.c	Thu May 24 19:45:59 2001
@@ -1118,7 +1118,7 @@
 	return (0);
 }
 /*==========================================================================*
/
-#endif 00000
+#endif /* 00000 */
 /*==========================================================================*
/
 static int ResponseInfo(void)
 {
diff -urN -X /linux/dontdiff linux/drivers/media/video/tuner.c 
rb/drivers/media/video/tuner.c
--- linux/drivers/media/video/tuner.c	Mon Feb 19 17:43:36 2001
+++ rb/drivers/media/video/tuner.c	Tue May 22 16:45:02 2001
@@ -558,6 +558,7 @@
 #endif
 	default:
 		/* nothing */
+		break;
 	}
 	
 	return 0;
diff -urN -X /linux/dontdiff linux/drivers/net/tokenring/ibmtr.c 
rb/drivers/net/tokenring/ibmtr.c
--- linux/drivers/net/tokenring/ibmtr.c	Tue Mar 20 15:05:00 2001
+++ rb/drivers/net/tokenring/ibmtr.c	Tue May 22 16:45:03 2001
@@ -1185,7 +1185,7 @@
 				isa_writeb(~CMD_IN_SRB, ti->mmio + ACA_OFFSET + ACA_RESET + ISRA_ODD);
 				isa_writeb(~SRB_RESP_INT, ti->mmio + ACA_OFFSET + ACA_RESET + ISRP_ODD);
 
-			  skip_reset:
+			  skip_reset:;
 			} /* SRB response */
 
 			if (status & ASB_FREE_INT) { /* ASB response */
diff -urN -X /linux/dontdiff linux/drivers/net/wan/hdlc.c 
rb/drivers/net/wan/hdlc.c
--- linux/drivers/net/wan/hdlc.c	Wed Apr 18 16:40:07 2001
+++ rb/drivers/net/wan/hdlc.c	Tue May 22 16:45:03 2001
@@ -1082,7 +1082,9 @@
 			}
 			break;
 
-		default:		/* to be defined */
+		default:
+			/* to be defined */
+			break;
 		}
 
 		dev_kfree_skb(skb);
diff -urN -X /linux/dontdiff linux/drivers/net/wan/sdla_fr.c 
rb/drivers/net/wan/sdla_fr.c
--- linux/drivers/net/wan/sdla_fr.c	Fri Apr 20 13:54:22 2001
+++ rb/drivers/net/wan/sdla_fr.c	Tue May 22 16:45:03 2001
@@ -4435,7 +4435,8 @@
 		trigger_fr_poll(dev);
 		
 		break;
-	default:  // ARP's and RARP's -- Shouldn't happen.
+	default:
+		break; // ARP's and RARP's -- Shouldn't happen.
 	}
 
 	return 0;	
diff -urN -X /linux/dontdiff linux/drivers/net/wan/sdla_x25.c 
rb/drivers/net/wan/sdla_x25.c
--- linux/drivers/net/wan/sdla_x25.c	Fri Apr 20 13:54:22 2001
+++ rb/drivers/net/wan/sdla_x25.c	Tue May 22 16:45:03 2001
@@ -3108,7 +3108,7 @@
 	case 0x08:	/* modem failure */
 #ifndef MODEM_NOT_LOG
 		printk(KERN_INFO "%s: modem failure!\n", card->devname);
-#endif MODEM_NOT_LOG
+#endif /* MODEM_NOT_LOG */
 		api_oob_event(card,mb);
 		break;
 
diff -urN -X /linux/dontdiff linux/drivers/scsi/NCR53c406a.c 
rb/drivers/scsi/NCR53c406a.c
--- linux/drivers/scsi/NCR53c406a.c	Thu May 24 19:35:06 2001
+++ rb/drivers/scsi/NCR53c406a.c	Tue May 22 16:45:03 2001
@@ -221,7 +221,7 @@
     (void *)0xc8000
 };
 #define ADDRESS_COUNT (sizeof( addresses ) / sizeof( unsigned ))
-#endif USE_BIOS
+#endif /* USE_BIOS */
 		       
 /* possible i/o port addresses */
 static unsigned short ports[] =
@@ -244,7 +244,7 @@
     { "Copyright (C) Acculogic, Inc.\r\n2.8M Diskette Extension Bios ver 
4.04.03 03/01/1993", 61, 82 },
 };
 #define SIGNATURE_COUNT (sizeof( signatures ) / sizeof( struct signature ))
-#endif USE_BIOS
+#endif /* USE_BIOS */
 
 /* ============================================================ */
 
@@ -347,7 +347,7 @@
     
     return tmp;
 }
-#endif USE_DMA
+#endif /* USE_DMA */
 
 #if USE_PIO
 static __inline__ int NCR53c406a_pio_read(unsigned char *request, 
@@ -455,7 +455,7 @@
     }
     return 0;
 }
-#endif USE_PIO
+#endif /* USE_PIO */
 
 int  __init 
 NCR53c406a_detect(Scsi_Host_Template * tpnt){
@@ -481,7 +481,7 @@
     }
     
     DEB(printk("NCR53c406a BIOS found at %X\n", (unsigned int) bios_base););
-#endif USE_BIOS
+#endif /* USE_BIOS */
     
 #ifdef PORT_BASE
     if (!request_region(port_base, 0x10, "NCR53c406a")) /* ports already 
snatched */
@@ -512,7 +512,7 @@
             }
         }
     }
-#endif PORT_BASE
+#endif /* PORT_BASE */
     
     if(!port_base){		/* no ports found */
         printk("NCR53c406a: no available ports found\n");
@@ -550,7 +550,7 @@
 #if USE_DMA
         printk("NCR53c406a: No interrupts found and DMA mode defined. Giving 
up.\n");
         goto err_release;
-#endif USE_DMA
+#endif /* USE_DMA */
     }
     else {
         DEB(printk("NCR53c406a: Shouldn't get here!\n"));
@@ -565,7 +565,7 @@
     }
     
     DEB(printk("Allocated DMA channel %d\n", dma_chan));
-#endif USE_DMA 
+#endif /* USE_DMA */
     
     tpnt->present = 1;
     tpnt->proc_name = "NCR53c406a";
@@ -820,8 +820,8 @@
     printk("\n");
 #else
     printk(", pio=%02x\n", pio_status);
-#endif USE_DMA
-#endif NCR53C406A_DEBUG
+#endif /* USE_DMA */
+#endif /* NCR53C406A_DEBUG */
     
     if(int_reg & 0x80){         /* SCSI reset intr */
         rtrc(3);
@@ -840,7 +840,7 @@
         current_SC->scsi_done(current_SC);
         return;
     }
-#endif USE_PIO
+#endif /* USE_PIO */
     
     if(status & 0x20) {		/* Parity error */
         printk("NCR53c406a: Warning: parity error!\n");
@@ -885,7 +885,7 @@
 #if USE_DMA			/* No s/g support for DMA */
             NCR53c406a_dma_write(current_SC->request_buffer, 
                                  current_SC->request_bufflen);
-#endif USE_DMA
+#endif /* USE_DMA */
             outb(TRANSFER_INFO | DMA_OP, CMD_REG); 
 #if USE_PIO
             if (!current_SC->use_sg) /* Don't use scatter-gather */
@@ -900,7 +900,7 @@
                 }
             }
             REG0;
-#endif USE_PIO
+#endif /* USE_PIO */
         }
         break;
         
@@ -914,7 +914,7 @@
 #if USE_DMA			/* No s/g support for DMA */
             NCR53c406a_dma_read(current_SC->request_buffer, 
                                 current_SC->request_bufflen);
-#endif USE_DMA
+#endif /* USE_DMA */
             outb(TRANSFER_INFO | DMA_OP, CMD_REG); 
 #if USE_PIO
             if (!current_SC->use_sg) /* Don't use scatter-gather */
@@ -929,7 +929,7 @@
                 }
             }
             REG0;
-#endif USE_PIO
+#endif /* USE_PIO */
         }
         break;
         
@@ -1011,7 +1011,7 @@
     
     return irq;
 }
-#endif IRQ_LEV
+#endif /* IRQ_LEV */
 
 static void chip_init()
 {
diff -urN -X /linux/dontdiff linux/drivers/scsi/aic7xxx_old.c 
rb/drivers/scsi/aic7xxx_old.c
--- linux/drivers/scsi/aic7xxx_old.c	Fri Apr 27 15:59:18 2001
+++ rb/drivers/scsi/aic7xxx_old.c	Tue May 22 16:45:03 2001
@@ -10100,7 +10100,7 @@
       } /* while(pdev=....) */
     } /* for PCI_DEVICES */
   } /* PCI BIOS present */
-#endif CONFIG_PCI
+#endif /* CONFIG_PCI */
 
 #if defined(__i386__) || defined(__alpha__)
   /*
diff -urN -X /linux/dontdiff linux/drivers/scsi/osst.c rb/drivers/scsi/osst.c
--- linux/drivers/scsi/osst.c	Thu Jan  4 16:00:55 2001
+++ rb/drivers/scsi/osst.c	Tue May 22 16:45:03 2001
@@ -3668,7 +3668,7 @@
 #if DEBUG
 		if (debugging)
 		    printk(OSST_DEB_MSG "osst%d: Locking drive door.\n", dev);
-#endif;
+#endif
 		break;
 
 	 case MTUNLOCK:
@@ -3678,7 +3678,7 @@
 #if DEBUG
 		if (debugging)
 		   printk(OSST_DEB_MSG "osst%d: Unlocking drive door.\n", dev);
-#endif;
+#endif
 	break;
 
 	 case MTSETBLK:           /* Set block length */
diff -urN -X /linux/dontdiff linux/drivers/scsi/scsi.c rb/drivers/scsi/scsi.c
--- linux/drivers/scsi/scsi.c	Thu May 24 19:35:07 2001
+++ rb/drivers/scsi/scsi.c	Tue May 22 16:45:03 2001
@@ -2358,6 +2358,7 @@
 	case MODULE_SCSI_IOCTL:
 		break;
 	default:
+		break;
 	}
 	return;
 }
diff -urN -X /linux/dontdiff linux/drivers/scsi/sym53c8xx.c 
rb/drivers/scsi/sym53c8xx.c
--- linux/drivers/scsi/sym53c8xx.c	Fri Apr 27 15:59:19 2001
+++ rb/drivers/scsi/sym53c8xx.c	Tue May 22 16:45:03 2001
@@ -11564,6 +11564,7 @@
 	OUTL_DSP (NCB_SCRIPT_PHYS (np, clrack));
 	return;
 out_stuck:
+	return;
 }
 
 
diff -urN -X /linux/dontdiff linux/drivers/sound/gus_wave.c 
rb/drivers/sound/gus_wave.c
--- linux/drivers/sound/gus_wave.c	Sun Nov 12 23:35:35 2000
+++ rb/drivers/sound/gus_wave.c	Tue May 22 16:45:03 2001
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
diff -urN -X /linux/dontdiff linux/drivers/sound/pss.c rb/drivers/sound/pss.c
--- linux/drivers/sound/pss.c	Sun Feb  4 13:05:29 2001
+++ rb/drivers/sound/pss.c	Tue May 22 16:45:03 2001
@@ -766,6 +766,7 @@
 			break;
 
 		default:
+			break;
 	}
 	return 0;
 }
diff -urN -X /linux/dontdiff linux/drivers/sound/wavfront.c 
rb/drivers/sound/wavfront.c
--- linux/drivers/sound/wavfront.c	Fri Mar  2 14:12:11 2001
+++ rb/drivers/sound/wavfront.c	Tue May 22 16:45:03 2001
@@ -131,7 +131,7 @@
 #if    OSS_SUPPORT_LEVEL & OSS_SUPPORT_SEQ
 static int (*midi_load_patch) (int devno, int format, const char *addr,
 			       int offs, int count, int pmgr_flag) = NULL;
-#endif OSS_SUPPORT_SEQ
+#endif /* OSS_SUPPORT_SEQ */
 
 /* if WF_DEBUG not defined, no run-time debugging messages will
    be available via the debug flag setting. Given the current
@@ -279,7 +279,7 @@
         int fx_mididev;                    /* devno for FX MIDI interface */
 #if OSS_SUPPORT_LEVEL & OSS_SUPPORT_SEQ
 	int oss_dev;                      /* devno for OSS sequencer synth */
-#endif OSS_SUPPORT_SEQ
+#endif /* OSS_SUPPORT_SEQ */
 
 	char fw_version[2];                /* major = [0], minor = [1] */
 	char hw_version[2];                /* major = [0], minor = [1] */
@@ -2139,7 +2139,7 @@
 	bender:		midi_synth_bender,
 	setup_voice:	midi_synth_setup_voice
 };
-#endif OSS_SUPPORT_SEQ
+#endif /* OSS_SUPPORT_SEQ */
 
 #if OSS_SUPPORT_LEVEL & OSS_SUPPORT_STATIC_INSTALL
 
@@ -2158,7 +2158,7 @@
     (void) uninstall_wavefront ();
 }
 
-#endif OSS_SUPPORT_STATIC_INSTALL
+#endif /* OSS_SUPPORT_STATIC_INSTALL */
 
 /***********************************************************************/
 /* WaveFront: Linux modular sound kernel installation interface        */
@@ -2674,7 +2674,7 @@
 		    &wavefront_oss_load_patch;
 	}
 
-#endif OSS_SUPPORT_SEQ
+#endif /* OSS_SUPPORT_SEQ */
 	
 	/* Turn on Virtual MIDI, but first *always* turn it off,
 	   since otherwise consectutive reloads of the driver will
@@ -2852,14 +2852,14 @@
 	} else {
 		synth_devs[dev.oss_dev] = &wavefront_operations;
 	}
-#endif OSS_SUPPORT_SEQ
+#endif /* OSS_SUPPORT_SEQ */
 
 	if (wavefront_init (1) < 0) {
 		printk (KERN_WARNING LOGNAME "initialization failed.\n");
 
 #if OSS_SUPPORT_LEVEL & OSS_SUPPORT_SEQ
 		sound_unload_synthdev (dev.oss_dev);
-#endif OSS_SUPPORT_SEQ
+#endif /* OSS_SUPPORT_SEQ */
 
 		return -1;
 	}
@@ -2890,7 +2890,7 @@
 
 #if OSS_SUPPORT_LEVEL & OSS_SUPPORT_SEQ
 	sound_unload_synthdev (dev.oss_dev);
-#endif OSS_SUPPORT_SEQ
+#endif /* OSS_SUPPORT_SEQ */
 	uninstall_wf_mpu ();
 }
 
diff -urN -X /linux/dontdiff linux/drivers/sound/wf_midi.c 
rb/drivers/sound/wf_midi.c
--- linux/drivers/sound/wf_midi.c	Sun Sep 17 11:45:07 2000
+++ rb/drivers/sound/wf_midi.c	Tue May 22 16:45:03 2001
@@ -231,6 +231,7 @@
 				break;
 		    
 			default:
+				break;
 			}
 		} else {
 			mi->m_prev_status = midic;
diff -urN -X /linux/dontdiff linux/drivers/sound/ymfpci.c 
rb/drivers/sound/ymfpci.c
--- linux/drivers/sound/ymfpci.c	Thu May 24 19:35:08 2001
+++ rb/drivers/sound/ymfpci.c	Thu May 24 19:47:13 2001
@@ -1829,6 +1829,7 @@
 		 * for instance we get SNDCTL_TMR_CONTINUE here.
 		 * XXX Is there sound_generic_ioctl() around?
 		 */
+		 break;
 	}
 	return -ENOTTY;
 }
diff -urN -X /linux/dontdiff linux/drivers/sound/yss225.h 
rb/drivers/sound/yss225.h
--- linux/drivers/sound/yss225.h	Sat Jul 18 16:11:41 1998
+++ rb/drivers/sound/yss225.h	Tue May 22 16:45:03 2001
@@ -20,5 +20,5 @@
 extern unsigned char coefficients3[404];
 
 
-#endif __ys225_h__
+#endif /* __ys225_h__ */
 
diff -urN -X /linux/dontdiff linux/drivers/usb/net1080.c 
rb/drivers/usb/net1080.c
--- linux/drivers/usb/net1080.c	Thu May 24 19:35:08 2001
+++ rb/drivers/usb/net1080.c	Tue May 22 16:45:03 2001
@@ -599,7 +599,7 @@
 	}
 #ifdef	VERBOSE
 	dbg ("no read resubmitted");
-#endif	VERBOSE
+#endif	/* VERBOSE */
 }
 
 /*-------------------------------------------------------------------------*/
diff -urN -X /linux/dontdiff linux/drivers/usb/pwc-uncompress.c 
rb/drivers/usb/pwc-uncompress.c
--- linux/drivers/usb/pwc-uncompress.c	Thu May 24 19:35:08 2001
+++ rb/drivers/usb/pwc-uncompress.c	Thu May 24 20:01:36 2001
@@ -25,6 +25,8 @@
 #include "vcvt.h"
 #include "pwc.h"
 #include "pwc-uncompress.h"
+#include <linux/module.h>
+#include <linux/slab.h>
 
 
 /* This contains a list of all registered decompressors */
diff -urN -X /linux/dontdiff linux/fs/sysv/inode.c rb/fs/sysv/inode.c
--- linux/fs/sysv/inode.c	Wed Apr 18 01:16:39 2001
+++ rb/fs/sysv/inode.c	Tue May 22 16:45:03 2001
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
diff -urN -X /linux/dontdiff linux/include/asm-i386/mca_dma.h 
rb/include/asm-i386/mca_dma.h
--- linux/include/asm-i386/mca_dma.h	Wed Apr 12 11:47:29 2000
+++ rb/include/asm-i386/mca_dma.h	Thu May 24 09:43:06 2001
@@ -199,4 +199,4 @@
 	outb(mode, MCA_DMA_REG_EXE);
 }
 
-#endif MCA_DMA_H
+#endif /* MCA_DMA_H */
diff -urN -X /linux/dontdiff linux/include/linux/coda_cache.h 
rb/include/linux/coda_cache.h
--- linux/include/linux/coda_cache.h	Tue Sep 19 17:08:59 2000
+++ rb/include/linux/coda_cache.h	Tue May 22 16:45:03 2001
@@ -19,4 +19,4 @@
 /* for downcalls and attributes and lookups */
 void coda_flag_inode_children(struct inode *inode, int flag);
 
-#endif _CFSNC_HEADER_
+#endif /* _CFSNC_HEADER_ */
diff -urN -X /linux/dontdiff linux/net/ipv4/netfilter/ipfwadm_core.c 
rb/net/ipv4/netfilter/ipfwadm_core.c
--- linux/net/ipv4/netfilter/ipfwadm_core.c	Fri Aug  4 20:18:49 2000
+++ rb/net/ipv4/netfilter/ipfwadm_core.c	Tue May 22 16:45:03 2001
@@ -515,7 +515,7 @@
 			}
 			continue;	/* Mismatch */
 
-		ifa_ok:
+		ifa_ok:;
 		}
 
 		/*
diff -urN -X /linux/dontdiff linux/net/ipv4/netfilter/ipt_REJECT.c 
rb/net/ipv4/netfilter/ipt_REJECT.c
--- linux/net/ipv4/netfilter/ipt_REJECT.c	Fri Apr 27 16:15:01 2001
+++ rb/net/ipv4/netfilter/ipt_REJECT.c	Tue May 22 16:45:03 2001
@@ -312,6 +312,7 @@
 		break;
 	case IPT_ICMP_ECHOREPLY:
 		/* Doesn't happen. */
+		break;
 	}
 
 	return NF_DROP;
diff -urN -X /linux/dontdiff linux/net/khttpd/security.h 
rb/net/khttpd/security.h
--- linux/net/khttpd/security.h	Wed Aug 18 11:45:10 1999
+++ rb/net/khttpd/security.h	Tue May 22 16:45:03 2001
@@ -9,4 +9,5 @@
 	char value[32-sizeof(void*)];  /* fill 1 cache-line */
 };
 
-#endif
\ No newline at end of file
+#endif
+
diff -urN -X /linux/dontdiff linux/net/sched/sch_cbq.c rb/net/sched/sch_cbq.c
--- linux/net/sched/sch_cbq.c	Sun Mar 25 21:14:25 2001
+++ rb/net/sched/sch_cbq.c	Tue May 22 16:45:03 2001
@@ -282,6 +282,7 @@
 		case TC_POLICE_SHOT:
 			return NULL;
 		default:
+			break;
 		}
 #endif
 		if (cl->level == 0)
