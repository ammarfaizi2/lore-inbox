Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131699AbRAFNz7>; Sat, 6 Jan 2001 08:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131701AbRAFNzt>; Sat, 6 Jan 2001 08:55:49 -0500
Received: from [139.102.15.43] ([139.102.15.43]:15598 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S131699AbRAFNzh>; Sat, 6 Jan 2001 08:55:37 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: linux-kernel@vger.kernel.org
Date: Sat, 6 Jan 2001 08:54:52 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [PATCH] Fix compile warnings in 2.4.0
Reply-to: richbaum@acm.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Message-ID: <3A56DD5C.7108.C0391@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch against 2.4.0 that fixes compile warnings with the 
20001225 gcc snapshot.  This patch fixes more warnings of the 
type that my patches for 2.4.0-prerelease.

diff -urN -X dontdiff linux/drivers/cdrom/cm207.c rb/drivers/cdrom/cm206.c
--- linux/drivers/cdrom/cm206.c	Fri Oct 27 01:35:47 2000
+++ rb/drivers/cdrom/cm206.c	Fri Jan  5 20:36:20 2001
@@ -1283,7 +1283,7 @@
   case 1: 
     kfree(cd);
     release_region(cm206_base, 16);
-  default:
+  default:;
   }
 }
 
diff -urN -X dontdiff linux/drivers/cdrom/cm206.h rb/drivers/cdrom/cm206.h
--- linux/drivers/cdrom/cm206.h	Tue Dec  2 14:41:44 1997
+++ rb/drivers/cdrom/cm206.h	Fri Jan  5 20:36:10 2001
@@ -166,6 +166,6 @@
 #undef y
 #undef x
 
-#endif STATISTICS
+#endif /* STATISTICS */
 
-#endif LINUX_CM206_H
+#endif /* LINUX_CM206_H */
diff -urN -X dontdiff linux/drivers/cdrom/mcd.c rb/drivers/cdrom/mcd.c
--- linux/drivers/cdrom/mcd.c	Fri Oct 27 01:35:47 2000
+++ rb/drivers/cdrom/mcd.c	Fri Jan  5 20:36:42 2001
@@ -1158,7 +1158,7 @@
       return;
     }
     blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
-  default:
+  default:;
   }
 }
 
diff -urN -X dontdiff linux/drivers/cdrom/optcd.c rb/drivers/cdrom/optcd.c
--- linux/drivers/cdrom/optcd.c	Fri Oct 27 01:35:48 2000
+++ rb/drivers/cdrom/optcd.c	Fri Jan  5 20:38:48 2001
@@ -924,7 +924,7 @@
 		return -EIO;
 	return 0;
 }
-#endif MULTISESSION
+#endif /* MULTISESSION */
 
 
 static int update_toc(void)
@@ -962,7 +962,7 @@
 #ifdef MULTISESSION
  	if (disk_info.xa)
 		get_multi_disk_info();	/* Here disk_info.multi is set */
-#endif MULTISESSION
+#endif /* MULTISESSION */
 	if (disk_info.multi)
 		printk(KERN_WARNING "optcd: Multisession support experimental, "
 			"see linux/Documentation/cdrom/optcd\n");
@@ -1709,11 +1709,11 @@
 			disk_info.last_session.minute,
 			disk_info.last_session.second,
 			disk_info.last_session.frame);
-#endif DEBUG_MULTIS
+#endif /* DEBUG_MULTIS */
 
 	return 0;
 }
-#endif MULTISESSION
+#endif /* MULTISESSION */
 
 
 static int cdromreset(void)
@@ -2026,7 +2026,7 @@
 
 __setup("optcd=", optcd_setup);
 
-#endif MODULE
+#endif /* MODULE */
 
 /* Test for presence of drive and initialize it. Called at boot time
    or during module initialisation. */
diff -urN -X dontdiff linux/drivers/cdrom/optcd.h rb/drivers/cdrom/optcd.h
--- linux/drivers/cdrom/optcd.h	Tue Dec  2 14:41:44 1997
+++ rb/drivers/cdrom/optcd.h	Fri Jan  5 20:36:59 2001
@@ -49,4 +49,4 @@
 #define N_BUFS		6
 
 
-#endif _LINUX_OPTCD_H
+#endif /* _LINUX_OPTCD_H */
diff -urN -X dontdiff linux/drivers/char/ftape/lowlevel/fdc-isr.c rb/drivers/char/ftape/lowlevel/fdc-isr.c
--- linux/drivers/char/ftape/lowlevel/fdc-isr.c	Mon Oct 16 14:58:51 2000
+++ rb/drivers/char/ftape/lowlevel/fdc-isr.c	Fri Jan  5 20:43:04 2001
@@ -81,7 +81,7 @@
 	case overrun_error:
 		TRACE(ft_t_noise, "overrun error");
 		break;
-	default:
+	default:;
 	}
 	TRACE_EXIT;
 }
@@ -184,7 +184,7 @@
 	case no_data_error:
 		ft_history.no_data_errors++;
 		break;
-	default:
+	default:;
 	}
 }
 
diff -urN -X dontdiff linux/drivers/i2o/i2o_lan.c rb/drivers/i2o/i2o_lan.c
--- linux/drivers/i2o/i2o_lan.c	Mon Dec 11 15:39:44 2000
+++ rb/drivers/i2o/i2o_lan.c	Fri Jan  5 20:16:04 2001
@@ -938,7 +938,7 @@
 	spin_unlock_irq(&priv->tx_lock);
 	return 0;
 }
-#endif CONFIG_NET_FC
+#endif /* CONFIG_NET_FC */
 
 /*
  * i2o_lan_packet_send(): Send a packet as is, including the MAC header.
diff -urN -X dontdiff linux/drivers/ieee1394/pcilynx.c rb/drivers/ieee1394/pcilynx.c
--- linux/drivers/ieee1394/pcilynx.c	Wed Nov 29 00:45:16 2000
+++ rb/drivers/ieee1394/pcilynx.c	Fri Jan  5 20:15:30 2001
@@ -1485,7 +1485,7 @@
                 pci_free_consistent(lynx->dev, LOCALRAM_SIZE, lynx->pcl_mem,
                                     lynx->pcl_mem_dma);
 #endif
-        case clear:
+        case clear:;
                 /* do nothing - already freed */
         }
 
diff -urN -X dontdiff linux/drivers/isdn/eicon/eicon_idi.c rb/drivers/isdn/eicon/eicon_idi.c
--- linux/drivers/isdn/eicon/eicon_idi.c	Sun Aug 13 12:05:32 2000
+++ rb/drivers/isdn/eicon/eicon_idi.c	Fri Jan  5 20:15:08 2001
@@ -2506,7 +2506,7 @@
 						case ISDN_PROTO_L2_TRANS:
 							idi_do_req(ccard, chan, N_CONNECT, 1);
 							break;
-						default:
+						default:;
 							/* On most incoming calls we use automatic connect */
 							/* idi_do_req(ccard, chan, N_CONNECT, 1); */
 					}
diff -urN -X dontdiff linux/drivers/isdn/eicon/eicon_pci.c rb/drivers/isdn/eicon/eicon_pci.c
--- linux/drivers/isdn/eicon/eicon_pci.c	Sun Aug 13 12:05:32 2000
+++ rb/drivers/isdn/eicon/eicon_pci.c	Fri Jan  5 20:14:49 2001
@@ -86,7 +86,7 @@
 				printk(KERN_INFO "%s: DriverID='%s' CardID=%d\n",
 					eicon_ctype_name[ctype], did, card_id);
 			}
-err:
+err:;
 		}
 		pCard++;
 	}
diff -urN -X dontdiff linux/drivers/isdn/hisax/hisax.h rb/drivers/isdn/hisax/hisax.h
--- linux/drivers/isdn/hisax/hisax.h	Fri Jan  5 20:27:54 2001
+++ rb/drivers/isdn/hisax/hisax.h	Fri Jan  5 20:09:52 2001
@@ -126,13 +126,13 @@
   #define l3dss1_process
   #include "l3dss1.h" 
   #undef  l3dss1_process
-#endif CONFIG_HISAX_EURO
+#endif /* CONFIG_HISAX_EURO */
 
 #ifdef CONFIG_HISAX_NI1
   #define l3ni1_process
   #include "l3ni1.h" 
   #undef  l3ni1_process
-#endif CONFIG_HISAX_NI1
+#endif /* CONFIG_HISAX_NI1 */
 
 #define MAX_DFRAME_LEN	260
 #define MAX_DFRAME_LEN_L1	300
@@ -318,10 +318,10 @@
 	 { u_char uuuu; /* only as dummy */
 #ifdef CONFIG_HISAX_EURO
            dss1_stk_priv dss1; /* private dss1 data */
-#endif CONFIG_HISAX_EURO              
+#endif /* CONFIG_HISAX_EURO */              
 #ifdef CONFIG_HISAX_NI1
            ni1_stk_priv ni1; /* private ni1 data */
-#endif CONFIG_HISAX_NI1              
+#endif /* CONFIG_HISAX_NI1 */             
 	 } prot;
 };
 
@@ -342,10 +342,10 @@
 	 { u_char uuuu; /* only when euro not defined, avoiding empty union */
 #ifdef CONFIG_HISAX_EURO 
            dss1_proc_priv dss1; /* private dss1 data */
-#endif CONFIG_HISAX_EURO            
+#endif /* CONFIG_HISAX_EURO */            
 #ifdef CONFIG_HISAX_NI1
            ni1_proc_priv ni1; /* private ni1 data */
-#endif CONFIG_HISAX_NI1              
+#endif /* CONFIG_HISAX_NI1 */             
 	 } prot;
 };
 
diff -urN -X dontdiff linux/drivers/isdn/hisax/isac.c rb/drivers/isdn/hisax/isac.c
--- linux/drivers/isdn/hisax/isac.c	Mon Nov 27 19:53:43 2000
+++ rb/drivers/isdn/hisax/isac.c	Fri Jan  5 20:11:12 2001
@@ -445,7 +445,7 @@
 				if (cs->debug & L1_DEB_MONITOR)
 					debugl1(cs, "ISAC %02x -> MOX1", cs->dc.isac.mon_tx[cs->dc.isac.mon_txp -1]);
 			}
-		      AfterMOX1:
+		      AfterMOX1:;
 #endif
 		}
 	}
diff -urN -X dontdiff linux/drivers/isdn/hisax/l3dss1.c rb/drivers/isdn/hisax/l3dss1.c
--- linux/drivers/isdn/hisax/l3dss1.c	Mon Nov 27 19:53:43 2000
+++ rb/drivers/isdn/hisax/l3dss1.c	Fri Jan  5 20:10:57 2001
@@ -426,9 +426,9 @@
 #undef FOO1
 
 			}
-#else  not HISAX_DE_AOC
+#else  /* not HISAX_DE_AOC */
                         l3_debug(st, "invoke break");
-#endif not HISAX_DE_AOC 
+#endif /* not HISAX_DE_AOC */
 			break;
 		case 2:	/* return result */
 			 /* if no process available handle separately */ 
diff -urN -X dontdiff linux/drivers/isdn/isdn_common.c rb/drivers/isdn/isdn_common.c
--- linux/drivers/isdn/isdn_common.c	Tue Jan  2 19:45:38 2001
+++ rb/drivers/isdn/isdn_common.c	Fri Jan  5 20:07:57 2001
@@ -41,7 +41,7 @@
 #endif
 #ifdef CONFIG_ISDN_DIVERSION
 #include <linux/isdn_divertif.h>
-#endif CONFIG_ISDN_DIVERSION
+#endif /* CONFIG_ISDN_DIVERSION */
 #include "isdn_v110.h"
 #include "isdn_cards.h"
 #include <linux/devfs_fs_kernel.h>
@@ -69,7 +69,7 @@
 
 #ifdef CONFIG_ISDN_DIVERSION
 static isdn_divert_if *divert_if; /* = NULL */
-#endif CONFIG_ISDN_DIVERSION
+#endif /* CONFIG_ISDN_DIVERSION */
 
 
 static int isdn_writebuf_stub(int, int, const u_char *, int, int);
@@ -519,7 +519,7 @@
                                          if (divert_if)
                  	                  if ((retval = divert_if->stat_callback(c))) 
 					    return(retval); /* processed */
-#endif CONFIG_ISDN_DIVERSION                        
+#endif /* CONFIG_ISDN_DIVERSION */                       
 					if ((!retval) && (dev->drv[di]->flags & DRV_FLAG_REJBUS)) {
 						/* No tty responding */
 						cmd.driver = di;
@@ -592,7 +592,7 @@
 #ifdef CONFIG_ISDN_DIVERSION
                         if (divert_if)
                          divert_if->stat_callback(c); 
-#endif CONFIG_ISDN_DIVERSION
+#endif /* CONFIG_ISDN_DIVERSION */
 			break;
 		case ISDN_STAT_DISPLAY:
 #ifdef ISDN_DEBUG_STATCALLB
@@ -602,7 +602,7 @@
 #ifdef CONFIG_ISDN_DIVERSION
                         if (divert_if)
                          divert_if->stat_callback(c); 
-#endif CONFIG_ISDN_DIVERSION
+#endif /* CONFIG_ISDN_DIVERSION */
 			break;
 		case ISDN_STAT_DCONN:
 			if (i < 0)
@@ -644,7 +644,7 @@
 #ifdef CONFIG_ISDN_DIVERSION
                         if (divert_if)
                          divert_if->stat_callback(c); 
-#endif CONFIG_ISDN_DIVERSION
+#endif /* CONFIG_ISDN_DIVERSION */
 			break;
 			break;
 		case ISDN_STAT_BCONN:
@@ -773,7 +773,7 @@
 	        case ISDN_STAT_REDIR:
                         if (divert_if)
                           return(divert_if->stat_callback(c));
-#endif CONFIG_ISDN_DIVERSION
+#endif /* CONFIG_ISDN_DIVERSION */
 		default:
 			return -1;
 	}
@@ -2166,7 +2166,7 @@
 
 EXPORT_SYMBOL(DIVERT_REG_NAME);
 
-#endif CONFIG_ISDN_DIVERSION
+#endif /* CONFIG_ISDN_DIVERSION */
 
 
 EXPORT_SYMBOL(register_isdn);
diff -urN -X dontdiff linux/drivers/isdn/isdn_tty.c rb/drivers/isdn/isdn_tty.c
--- linux/drivers/isdn/isdn_tty.c	Mon Nov 27 19:53:43 2000
+++ rb/drivers/isdn/isdn_tty.c	Fri Jan  5 20:05:44 2001
@@ -3773,7 +3773,7 @@
                                                 sprintf(ds, "\r\n%d", info->emu.charge);
                                                 isdn_tty_at_cout(ds, info);
                                                 break;
-					default:
+					default:;
 				}
 				break;
 #ifdef DUMMY_HAYES_AT
diff -urN -X dontdiff linux/drivers/isdn/isdn_v110.c rb/drivers/isdn/isdn_v110.c
--- linux/drivers/isdn/isdn_v110.c	Sun Aug  6 14:43:42 2000
+++ rb/drivers/isdn/isdn_v110.c	Fri Jan  5 20:05:29 2001
@@ -600,7 +600,7 @@
 					case ISDN_PROTO_L2_V11038:
 						dev->v110[idx] = isdn_v110_open(V110_38400, hdrlen, maxsize);
 						break;
-					default:
+					default:;
 				}
 				if ((v = dev->v110[idx])) {
 					while (v->SyncInit) {
diff -urN -X dontdiff linux/drivers/md/md.c rb/drivers/md/md.c
--- linux/drivers/md/md.c	Mon Dec 11 16:19:35 2000
+++ rb/drivers/md/md.c	Fri Jan  5 20:04:59 2001
@@ -2588,7 +2588,7 @@
 			err = md_put_user (read_ahead[
 				MAJOR(dev)], (long *) arg);
 			goto done;
-		default:
+		default:;
 	}
 
 	/*
@@ -2607,7 +2607,7 @@
 				err = -EEXIST;
 				goto abort;
 			}
-		default:
+		default:;
 	}
 	switch (cmd)
 	{
@@ -2660,7 +2660,7 @@
 			}
 			goto done;
 
-		default:
+		default:;
 	}
 
 	/*
diff -urN -X dontdiff linux/include/linux/nubus.h rb/include/linux/nubus.h
--- linux/include/linux/nubus.h	Sat Sep  4 15:10:30 1999
+++ rb/include/linux/nubus.h	Fri Jan  5 20:03:23 2001
@@ -319,4 +319,4 @@
 	return (void *)(0xF0000000|(slot<<24));
 }
 
-#endif LINUX_NUBUS_H
+#endif /* LINUX_NUBUS_H */
diff -urN -X dontdiff linux/include/net/ip_fib.h rb/include/net/ip_fib.h
--- linux/include/net/ip_fib.h	Fri Jan  5 20:02:11 2001
+++ rb/include/net/ip_fib.h	Fri Jan  5 20:21:12 2001
@@ -276,4 +276,4 @@
 }
 
 
-#endif  _NET_FIB_H
+#endif /* _NET_FIB_H */
diff -urN -X dontdiff linux/include/net/scm.h rb/include/net/scm.h
--- linux/include/net/scm.h	Tue Oct 27 12:57:19 1998
+++ rb/include/net/scm.h	Fri Jan  5 20:20:01 2001
@@ -63,5 +63,5 @@
 }
 
 
-#endif __LINUX_NET_SCM_H
+#endif /* __LINUX_NET_SCM_H */
 
diff -urN -X dontdiff linux/net/802/cl2llc.c rb/net/802/cl2llc.c
--- linux/net/802/cl2llc.c	Sat Nov 29 13:41:10 1997
+++ rb/net/802/cl2llc.c	Fri Jan  5 20:02:42 2001
@@ -96,7 +96,7 @@
 				else
 					llc_interpret_pseudo_code(lp, REJECT1, skb, NO_FRAME);
 				break;
-			default:
+			default:;
 		}
 		if(lp->llc_callbacks)
 		{
@@ -497,7 +497,7 @@
 				else
 					lp->f_flag = fr->i_hdr.i_pflag;
 				break;
-			default:
+			default:;
 		}
 		pc++;	
 	}
diff -urN -X dontdiff linux/net/802/llc_macinit.c rb/net/802/llc_macinit.c
--- linux/net/802/llc_macinit.c	Mon Oct 16 14:42:53 2000
+++ rb/net/802/llc_macinit.c	Fri Jan  5 20:02:22 2001
@@ -125,7 +125,7 @@
 				free=0;
 				break;
 
-			default:
+			default:;
 				/*
 				 *	All other type 1 pdus ignored for now
 				 */
diff -urN -X dontdiff linux/net/atm/lec.h rb/net/atm/lec.h
--- linux/net/atm/lec.h	Fri Jan  5 20:00:12 2001
+++ rb/net/atm/lec.h	Fri Jan  5 20:01:45 2001
@@ -154,5 +154,5 @@
 
 void atm_lane_init(void);
 void atm_lane_init_ops(struct atm_lane_ops *ops);
-#endif _LEC_H_
+#endif /* _LEC_H_ */
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
