Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135603AbRAGCmR>; Sat, 6 Jan 2001 21:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135615AbRAGCmH>; Sat, 6 Jan 2001 21:42:07 -0500
Received: from lists.indstate.edu ([139.102.15.43]:59522 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S135600AbRAGClt>; Sat, 6 Jan 2001 21:41:49 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: linux-kernel@vger.kernel.org
Date: Sat, 6 Jan 2001 21:40:51 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [PATCH] More compile warning fixes for 2.4.0
Reply-to: richbaum@acm.org
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <3A5790E3.18256.963C79@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that fixes more of the compile warnings with gcc 
2.97.

diff -urN -X dontdiff linux/drivers/atm/fore200e.c 
rb/drivers/atm/fore200e.c
--- linux/drivers/atm/fore200e.c	Fri Dec 29 17:35:47 2000
+++ rb/drivers/atm/fore200e.c	Sat Jan  6 14:33:42 2001
@@ -437,7 +437,7 @@
 	/* XXX shouldn't we *start* by deregistering the device? */
 	atm_dev_deregister(fore200e->atm_dev);
 
-    case FORE200E_STATE_BLANK:
+    case FORE200E_STATE_BLANK:;
 	/* nothing to do for that state */
     }
 }
diff -urN -X dontdiff linux/drivers/atm/iphase.c rb/drivers/atm/iphase.c
--- linux/drivers/atm/iphase.c	Fri Dec 29 17:35:47 2000
+++ rb/drivers/atm/iphase.c	Sat Jan  6 14:33:25 2001
@@ -951,7 +951,7 @@
                                   SUNI_PM7345_PLB);
 #ifdef __SNMP__
    suni_pm7345->suni_rxcp_intr_en_sts |= SUNI_OOCDE;
-#endif __SNMP__
+#endif /* __SNMP__ */
    return;
 }
 
diff -urN -X dontdiff linux/drivers/cdrom/sbpcd.c rb/drivers/cdrom/sbpcd.c
--- linux/drivers/cdrom/sbpcd.c	Fri Oct 27 01:35:48 2000
+++ rb/drivers/cdrom/sbpcd.c	Sat Jan  6 15:05:46 2001
@@ -338,7 +338,7 @@
 
 #ifndef SBPCD_ISSUE
 #define SBPCD_ISSUE 1
-#endif SBPCD_ISSUE
+#endif /* SBPCD_ISSUE */
 
 #include <linux/module.h>
 
@@ -408,7 +408,7 @@
 #else
 #define SBPCD_CLI
 #define SBPCD_STI
-#endif SBPCD_DIS_IRQ
+#endif /* SBPCD_DIS_IRQ */
 /*==========================================================================*/
 /*
  * auto-probing address list
@@ -466,9 +466,9 @@
 	0x370, 0, /* Lasermate, CI-101P */
 	0x290, 1, /* Soundblaster 16 */
 	0x310, 0, /* Lasermate, CI-101P, WDH-7001C */
-#endif MODULE
+#endif /* MODULE */
 #endif
-#endif DISTRIBUTION
+#endif /* DISTRIBUTION */
 };
 #else
 static int sbpcd[] = {CDROM_PORT, SBPRO}; /* probe with user's setup only */
@@ -557,7 +557,7 @@
 			  (1<<DBG_TOC) |
 			  (1<<DBG_MUL) |
 			  (1<<DBG_UPC));
-#endif DISTRIBUTION
+#endif /* DISTRIBUTION */
 
 static int sbpcd_ioaddr = CDROM_PORT;	/* default I/O base address */
 static int sbpro_type = SBPRO;
@@ -606,7 +606,7 @@
 
 #if FUTURE
 static DECLARE_WAIT_QUEUE_HEAD(sbp_waitq);
-#endif FUTURE
+#endif /* FUTURE */
 
 static int teac=SBP_TEAC_SPEED;
 static int buffers=SBP_BUFFER_FRAMES;
@@ -631,7 +631,7 @@
 #if OLD_BUSY
 static volatile u_char busy_data;
 static volatile u_char busy_audio; /* true semaphores would be safer */
-#endif OLD_BUSY
+#endif /* OLD_BUSY */
 static DECLARE_MUTEX(ioctl_read_sem);
 static u_long timeout;
 static volatile u_char timed_out_delay;
@@ -648,7 +648,7 @@
 static u_int maxtim_data= 9000;
 #else
 static u_int maxtim_data= 3000;
-#endif LONG_TIMING
+#endif /* LONG_TIMING */
 #if DISTRIBUTION
 static int n_retries=6;
 #else
@@ -713,7 +713,7 @@
 	u_char vol_ctrl2;
 	char vol_chan3;
 	u_char vol_ctrl3;
-#endif 000
+#endif /* 000 */
 	u_char volume_control; /* TEAC on/off bits */
 	
 	u_char SubQ_ctl_adr;
@@ -742,7 +742,7 @@
 	u_int TocEnt_address;
 #if SAFE_MIXED
 	char has_data;
-#endif SAFE_MIXED
+#endif /* SAFE_MIXED */
 	u_char ored_ctl_adr; /* to detect if CDROM contains data tracks */
 	
 	struct {
@@ -792,7 +792,7 @@
 #define MSG_LEVEL KERN_NOTICE
 #else
 #define MSG_LEVEL KERN_INFO
-#endif DISTRIBUTION
+#endif /* DISTRIBUTION */
 
 	char buf[256];
 	va_list args;
@@ -808,7 +808,7 @@
 	printk(buf);
 #if KLOGD_PAUSE
 	sbp_sleep(KLOGD_PAUSE); /* else messages get lost */
-#endif KLOGD_PAUSE
+#endif /* KLOGD_PAUSE */
 	return;
 }
 /*==========================================================================*/
@@ -1102,7 +1102,7 @@
 	return (0);
 }
 /*==========================================================================*/
-#endif 00000
+#endif /* 00000 */
 /*==========================================================================*/
 static int ResponseInfo(void)
 {
@@ -1132,7 +1132,7 @@
 	}
 	j=i-response_count;
 	if (j>0) msg(DBG_INF,"ResponseInfo: got %d trailing bytes.\n",j);
-#endif 000
+#endif /* 000 */
 	for (j=0;j<i;j++)
 		sprintf(&msgbuf[j*3]," %02X",infobuf[j]);
 	msgbuf[j*3]=0;
@@ -1384,7 +1384,7 @@
 		if (drvcmd[0]==CMDT_READ_VER) sbp_sleep(HZ); /* fixme */
 #if 01
 		OUT(CDo_sel_i_d,1);
-#endif 01
+#endif /* 01 */
 		if (teac==2)
                   {
                     if ((i=CDi_stat_loop_T()) == -1) break;
@@ -1393,7 +1393,7 @@
                   {
 #if 0
                     OUT(CDo_sel_i_d,1);
-#endif 0
+#endif /* 0 */
                     i=inb(CDi_status);
                   }
 		if (!(i&s_not_data_ready)) /* f.e. CMDT_DISKINFO */
@@ -1417,7 +1417,7 @@
                                                         l=1;
                                                         msg(DBG_TEA,"cmd_out_T: do_16bit: false fi
rst byte!\n");
                                                 }
-#endif TEST_FALSE_FF
+#endif /* TEST_FALSE_FF */
                                         }
                                         else infobuf[l++]=inb(CDi_data);
                                         i=inb(CDi_status);
@@ -2012,7 +2012,7 @@
 		msg(DBG_TEA, "================CMDT_RESET given=================.\n");
 		sbp_sleep(3*HZ);
 	}
-#endif 1
+#endif /* 1 */
 	flush_status();
 	i=GetStatus();
 	if (i<0) return i;
@@ -2333,7 +2333,7 @@
 		i=ResponseStatus();
 #if 0
                 sbp_sleep(HZ);
-#endif 0
+#endif /* 0 */
 		i=ResponseStatus();
 	}
 	if (i<0)
@@ -2678,7 +2678,7 @@
 	D_S[d].vol_ctrl2=0xFF;
 	D_S[d].vol_chan3=3;
 	D_S[d].vol_ctrl3=0xFF;
-#endif 000
+#endif /* 000 */
 	D_S[d].diskstate_flags |= volume_bit;
 	return (0);
 }
@@ -2978,20 +2978,20 @@
 	int i;
 #if TEST_UPC
 	int block, checksum;
-#endif TEST_UPC
+#endif /* TEST_UPC */
 	
 	if (fam2_drive) return (0); /* not implemented yet */
 	if (famT_drive)	return (0); /* not implemented yet */
 	if (famV_drive)	return (0); /* not implemented yet */
 #if 1
 	if (fam0_drive) return (0); /* but it should work */
-#endif 1
+#endif /* 1 */
 	
 	D_S[d].diskstate_flags &= ~upc_bit;
 #if TEST_UPC
 	for (block=CD_MSF_OFFSET+1;block<CD_MSF_OFFSET+200;block++)
 	{
-#endif TEST_UPC
+#endif /* TEST_UPC */
 		clr_cmdbuf();
 		if (fam1_drive)
 		{
@@ -3000,7 +3000,7 @@
 			drvcmd[1]=(block>>16)&0xFF;
 			drvcmd[2]=(block>>8)&0xFF;
 			drvcmd[3]=block&0xFF;
-#endif TEST_UPC
+#endif /* TEST_UPC */
 			response_count=8;
 			flags_cmd_out=f_putcmd|f_ResponseStatus|f_obey_p_check;
 		}
@@ -3011,7 +3011,7 @@
 			drvcmd[2]=(block>>16)&0xFF;
 			drvcmd[3]=(block>>8)&0xFF;
 			drvcmd[4]=block&0xFF;
-#endif TEST_UPC
+#endif /* TEST_UPC */
 			response_count=0;
 			flags_cmd_out=f_putcmd|f_lopsta|f_getsta|f_ResponseStatus|f_obey_p_check|f_bit1;
 		}
@@ -3042,12 +3042,12 @@
 		}
 #if TEST_UPC
 		checksum=0;
-#endif TEST_UPC
+#endif /* TEST_UPC */
 		for (i=0;i<(fam1_drive?8:16);i++)
 		{
 #if TEST_UPC
 			checksum |= infobuf[i];
-#endif TEST_UPC
+#endif /* TEST_UPC */
 			sprintf(&msgbuf[i*3], " %02X", infobuf[i]);
 		}
 		msgbuf[i*3]=0;
@@ -3055,7 +3055,7 @@
 #if TEST_UPC
 		if ((checksum&0x7F)!=0) break;
 	}
-#endif TEST_UPC
+#endif /* TEST_UPC */
 	D_S[d].UPC_ctl_adr=0;
 	if (fam1_drive) i=0;
 	else i=2;
diff -urN -X dontdiff linux/drivers/net/pcmcia/wavelan_cs.c rb/drivers/net/pcmcia/wavelan_cs.c
--- linux/drivers/net/pcmcia/wavelan_cs.c	Thu Jan  4 15:50:12 2001
+++ rb/drivers/net/pcmcia/wavelan_cs.c	Sat Jan  6 15:10:02 2001
@@ -1774,7 +1774,7 @@
 #if WIRELESS_EXT > 7
   const int	BAND_NUM = 10;	/* Number of bands */
   int		c = 0;		/* Channel number */
-#endif WIRELESS_EXT
+#endif /* WIRELESS_EXT */
 
   /* Read the frequency table */
   fee_read(base, 0x71 /* frequency table */,
@@ -1792,7 +1792,7 @@
 	      (c < BAND_NUM))
 	  c++;
 	list[i].i = c;	/* Set the list index */
-#endif WIRELESS_EXT
+#endif /* WIRELESS_EXT */
 
 	/* put in the list */
 	list[i].m = (((freq + 24) * 5) + 24000L) * 10000;
diff -urN -X dontdiff linux/drivers/net/pcmcia/xircom_tulip_cb.c rb/drivers/net/pcmcia/xircom_tulip
_cb.c
--- linux/drivers/net/pcmcia/xircom_tulip_cb.c	Tue Nov  7 14:09:19 2000
+++ rb/drivers/net/pcmcia/xircom_tulip_cb.c	Sat Jan  6 15:10:26 2001
@@ -2388,7 +2388,7 @@
 #ifdef CARDBUS
 		if (tp->chip_id == X3201_3)
 			tp->tx_aligned_skbuff[i] = dev_alloc_skb(PKT_BUF_SZ);
-#endif CARDBUS
+#endif /* CARDBUS */
 	}
 	tp->tx_ring[i-1].buffer2 = virt_to_bus(&tp->tx_ring[0]);
 }
diff -urN -X dontdiff linux/drivers/net/pppoe.c rb/drivers/net/pppoe.c
--- linux/drivers/net/pppoe.c	Mon Dec 11 15:37:03 2000
+++ rb/drivers/net/pppoe.c	Sat Jan  6 15:07:53 2001
@@ -737,7 +737,7 @@
 		err = 0;
 		break;
 
-	default:
+	default:;
 	};
 
 	return err;
diff -urN -X dontdiff linux/drivers/net/tokenring/ibmtr.c rb/drivers/net/tokenring/ibmtr.c
--- linux/drivers/net/tokenring/ibmtr.c	Mon Oct 16 14:58:51 2000
+++ rb/drivers/net/tokenring/ibmtr.c	Sat Jan  6 15:10:44 2001
@@ -1181,7 +1181,7 @@
 				isa_writeb(~CMD_IN_SRB, ti->mmio + ACA_OFFSET + ACA_RESET + ISRA_ODD);
 				isa_writeb(~SRB_RESP_INT, ti->mmio + ACA_OFFSET + ACA_RESET + ISRP_ODD);
 
-			  skip_reset:
+			  skip_reset:;
 			} /* SRB response */
 
 			if (status & ASB_FREE_INT) { /* ASB response */
diff -urN -X dontdiff linux/drivers/net/wan/lmc/lmc.h rb/drivers/net/wan/lmc/lmc.h
--- linux/drivers/net/wan/lmc/lmc.h	Mon Dec 11 15:59:54 2000
+++ rb/drivers/net/wan/lmc/lmc.h	Sat Jan  6 15:13:07 2001
@@ -29,4 +29,5 @@
 static void lmcEventLog( u_int32_t EventNum, u_int32_t arg2, u_int32_t arg3 );
 #endif
 
-#endif
\ No newline at end of file
+#endif
+
diff -urN -X dontdiff linux/drivers/net/wan/lmc/lmc_proto.h rb/drivers/net/wan/lmc/lmc_proto.h
--- linux/drivers/net/wan/lmc/lmc_proto.h	Fri Apr 21 18:08:45 2000
+++ rb/drivers/net/wan/lmc/lmc_proto.h	Sat Jan  6 15:13:19 2001
@@ -12,4 +12,5 @@
 void lmc_proto_netif(lmc_softc_t *sc, struct sk_buff *skb);
 int lmc_skb_rawpackets(char *buf, char **start, off_t offset, int len, int unused);
 
-#endif
\ No newline at end of file
+#endif
+
diff -urN -X dontdiff linux/drivers/scsi/NCR5380.h rb/drivers/scsi/NCR5380.h
--- linux/drivers/scsi/NCR5380.h	Sun Jun  7 12:37:41 1998
+++ rb/drivers/scsi/NCR5380.h	Sat Jan  6 15:16:49 2001
@@ -373,6 +373,6 @@
 }
 #endif /* defined(i386) || defined(__alpha__) */
 #endif /* defined(REAL_DMA)  */
-#endif __KERNEL_
+#endif /* __KERNEL_ */
 #endif /* ndef ASM */
 #endif /* NCR5380_H */
diff -urN -X dontdiff linux/drivers/scsi/NCR53c406a.c rb/drivers/scsi/NCR53c406a.c
--- linux/drivers/scsi/NCR53c406a.c	Mon Sep 18 15:36:24 2000
+++ rb/drivers/scsi/NCR53c406a.c	Sat Jan  6 15:21:01 2001
@@ -221,7 +221,7 @@
     (void *)0xc8000
 };
 #define ADDRESS_COUNT (sizeof( addresses ) / sizeof( unsigned ))
-#endif USE_BIOS
+#endif /* USE_BIOS */
 		       
 /* possible i/o port addresses */
 static unsigned short ports[] =
@@ -244,7 +244,7 @@
     { "Copyright (C) Acculogic, Inc.\r\n2.8M Diskette Extension Bios ver 4.04.03 03/01/1993", 61, 
82 },
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
     if (check_region(port_base, 0x10)) /* ports already snatched */
@@ -510,7 +510,7 @@
             }
         }
     }
-#endif PORT_BASE
+#endif /* PORT_BASE */
     
     if(!port_base){		/* no ports found */
         printk("NCR53c406a: no available ports found\n");
@@ -564,7 +564,7 @@
     }
     
     DEB(printk("Allocated DMA channel %d\n", dma_chan));
-#endif USE_DMA 
+#endif /* USE_DMA */
     
     tpnt->present = 1;
     tpnt->proc_name = "NCR53c406a";
@@ -804,8 +804,8 @@
     printk("\n");
 #else
     printk(", pio=%02x\n", pio_status);
-#endif USE_DMA
-#endif NCR53C406A_DEBUG
+#endif /* USE_DMA */
+#endif /* NCR53C406A_DEBUG */
     
     if(int_reg & 0x80){         /* SCSI reset intr */
         rtrc(3);
@@ -824,7 +824,7 @@
         current_SC->scsi_done(current_SC);
         return;
     }
-#endif USE_PIO
+#endif /* USE_PIO */
     
     if(status & 0x20) {		/* Parity error */
         printk("NCR53c406a: Warning: parity error!\n");
@@ -869,7 +869,7 @@
 #if USE_DMA			/* No s/g support for DMA */
             NCR53c406a_dma_write(current_SC->request_buffer, 
                                  current_SC->request_bufflen);
-#endif USE_DMA
+#endif /* USE_DMA */
             outb(TRANSFER_INFO | DMA_OP, CMD_REG); 
 #if USE_PIO
             if (!current_SC->use_sg) /* Don't use scatter-gather */
@@ -884,7 +884,7 @@
                 }
             }
             REG0;
-#endif USE_PIO
+#endif /* USE_PIO */
         }
         break;
         
@@ -898,7 +898,7 @@
 #if USE_DMA			/* No s/g support for DMA */
             NCR53c406a_dma_read(current_SC->request_buffer, 
                                 current_SC->request_bufflen);
-#endif USE_DMA
+#endif /* USE_DMA */
             outb(TRANSFER_INFO | DMA_OP, CMD_REG); 
 #if USE_PIO
             if (!current_SC->use_sg) /* Don't use scatter-gather */
@@ -913,7 +913,7 @@
                 }
             }
             REG0;
-#endif USE_PIO
+#endif /* USE_PIO */
         }
         break;
         
@@ -995,7 +995,7 @@
     
     return irq;
 }
-#endif IRQ_LEV
+#endif /* IRQ_LEV */
 
 static void chip_init()
 {
diff -urN -X dontdiff linux/drivers/scsi/aic7xxx.c rb/drivers/scsi/aic7xxx.c
--- linux/drivers/scsi/aic7xxx.c	Thu Oct 12 16:19:32 2000
+++ rb/drivers/scsi/aic7xxx.c	Sat Jan  6 15:16:20 2001
@@ -10099,7 +10099,7 @@
       } /* while(pdev=....) */
     } /* for PCI_DEVICES */
   } /* PCI BIOS present */
-#endif CONFIG_PCI
+#endif /* CONFIG_PCI */
 
 #if defined(__i386__) || defined(__alpha__)
   /*
diff -urN -X dontdiff linux/drivers/scsi/osst.c rb/drivers/scsi/osst.c
--- linux/drivers/scsi/osst.c	Thu Jan  4 16:00:55 2001
+++ rb/drivers/scsi/osst.c	Sat Jan  6 15:18:03 2001
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
diff -urN -X dontdiff linux/drivers/scsi/scsi.c rb/drivers/scsi/scsi.c
--- linux/drivers/scsi/scsi.c	Mon Oct 30 17:44:29 2000
+++ rb/drivers/scsi/scsi.c	Sat Jan  6 15:15:54 2001
@@ -2355,7 +2355,7 @@
 	case MODULE_SCSI_CONST:
 	case MODULE_SCSI_IOCTL:
 		break;
-	default:
+	default:;
 	}
 	return;
 }
diff -urN -X dontdiff linux/fs/isofs/inode.c rb/fs/isofs/inode.c
--- linux/fs/isofs/inode.c	Mon Jan  1 13:23:21 2001
+++ rb/fs/isofs/inode.c	Sat Jan  6 14:32:09 2001
@@ -616,7 +616,7 @@
 #ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
 	  if (isonum_723 (h_pri->volume_set_size) != 1)
 		goto out_no_support;
-#endif IGNORE_WRONG_MULTI_VOLUME_SPECS
+#endif /* IGNORE_WRONG_MULTI_VOLUME_SPECS */
 	  s->u.isofs_sb.s_nzones = isonum_733 (h_pri->volume_space_size);
 	  s->u.isofs_sb.s_log_zone_size = isonum_723 (h_pri->logical_block_size);
 	  s->u.isofs_sb.s_max_size = isonum_733(h_pri->volume_space_size);
@@ -625,7 +625,7 @@
 #ifndef IGNORE_WRONG_MULTI_VOLUME_SPECS
 	  if (isonum_723 (pri->volume_set_size) != 1)
 		goto out_no_support;
-#endif IGNORE_WRONG_MULTI_VOLUME_SPECS
+#endif /* IGNORE_WRONG_MULTI_VOLUME_SPECS */
 	  s->u.isofs_sb.s_nzones = isonum_733 (pri->volume_space_size);
 	  s->u.isofs_sb.s_log_zone_size = isonum_723 (pri->logical_block_size);
 	  s->u.isofs_sb.s_max_size = isonum_733(pri->volume_space_size);
diff -urN -X dontdiff linux/include/linux/if_frad.h rb/include/linux/if_frad.h
--- linux/include/linux/if_frad.h	Mon Dec 11 16:00:06 2000
+++ rb/include/linux/if_frad.h	Sat Jan  6 15:12:38 2001
@@ -194,7 +194,7 @@
 
 int (*dlci_ioctl_hook)(unsigned int, void *);
 
-#endif __KERNEL__
+#endif /* __KERNEL__ */
 
 #endif /* CONFIG_DLCI || CONFIG_DLCI_MODULE */
 
diff -urN -X dontdiff linux/kernel/sched.c rb/kernel/sched.c
--- linux/kernel/sched.c	Thu Jan  4 16:50:38 2001
+++ rb/kernel/sched.c	Sat Jan  6 14:31:10 2001
@@ -548,7 +548,7 @@
 			}
 		default:
 			del_from_runqueue(prev);
-		case TASK_RUNNING:
+		case TASK_RUNNING:;
 	}
 	prev->need_resched = 0;
 




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
