Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJCAE>; Tue, 9 Jan 2001 21:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbRAJB7y>; Tue, 9 Jan 2001 20:59:54 -0500
Received: from [139.102.15.43] ([139.102.15.43]:36549 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S129431AbRAJB7f>; Tue, 9 Jan 2001 20:59:35 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 9 Jan 2001 20:58:35 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
Reply-to: richbaum@acm.org
CC: Richard Henderson <rth@twiddle.net>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        richbaum@acm.org, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <3A5B7B7B.4542.8EAF18@localhost>
In-Reply-To: <200101091002.f09A2gw281603@saturn.cs.uml.edu>
In-Reply-To: <Pine.LNX.4.10.10101091048590.2070-100000@penguin.transmeta.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jan 2001, at 10:51, Linus Torvalds wrote:

> 
> 
> On Tue, 9 Jan 2001, Albert D. Cahalan wrote:
> 
> > [about labels w/o statements after them]
> > 
> > >> Is this really a kernel bug? This is common idiom in C, so 
gcc
> > >> shouldn't warn about it. If it does, it is a bug in gcc IMHO.
> > >
> > > No, it is not a common idiom in C.  It has _never_ been valid 
C.
> > >
> > > GCC originally allowed it due to a mistake in the grammar; 
we
> > > now warn for it.  Fix your source.
> > 
> > Since neither -ansi nor -std=foo was specified, gcc should just
> > shut up and be happy. Consider this as another GNU 
extension.
> 
> No, it was a gcc bug that gcc accepted the syntax in the first 
place.
> 
> Let the gcc people fix the bugs they find without complaining 
about them.
> After all, gcc would have been perfectly correct in signalling this 
as a
> syntax error, and aborted compilation. The fact that gcc only 
warns about
> it is a sign of grace - it's not as if it is a _useful_ extension that
> gives the programmer anything new and should be left in for that 
reason.
> 
> We'll fix up the kernel. That's where the bug is.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-
kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Here's a patch that takes care of all warnings of this type I have 
found in 2.4.0. If anyone else finds more of these warnings let me 
know or look at me patch to see how to do it yourself.
 

diff -urN -X dontdiff linux/drivers/block/cpqarray.c rb/drivers/block/cpqarray.c
--- linux/drivers/block/cpqarray.c	Thu Nov 16 14:30:29 2000
+++ rb/drivers/block/cpqarray.c	Tue Jan  9 18:13:59 2001
@@ -1321,7 +1321,7 @@
 	case IDA_WRITE_MEDIA:
 		kfree(p);
 		break;
-	default:
+	default:;
 		/* Nothing to do */
 	}
 
diff -urN -X dontdiff linux/drivers/cdrom/cm206.c rb/drivers/cdrom/cm206.c
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

diff -urN -X dontdiff linux/drivers/media/video/msp3400.c rb/drivers/media/video/msp3400.c
--- linux/drivers/media/video/msp3400.c	Sun Dec  3 20:45:22 2000
+++ rb/drivers/media/video/msp3400.c	Tue Jan  9 18:19:09 2001
@@ -1499,7 +1499,7 @@
 			 (int)msp3400c_read(client, I2C_MSP3400C_DFP, 0x1c));
 		break;
 #endif
-	default:
+	default:;
 		/* nothing */
 	}
 	return 0;
diff -urN -X dontdiff linux/drivers/mtd/nftlmount.c rb/drivers/mtd/nftlmount.c
--- linux/drivers/mtd/nftlmount.c	Fri Dec 29 17:07:22 2000
+++ rb/drivers/mtd/nftlmount.c	Tue Jan  9 18:14:43 2001
@@ -118,7 +118,7 @@
 				break;
 			}
 		}
-	ReplUnitTable:
+	ReplUnitTable:;
 	}
 
 	if (boot_record_count == 0) {
@@ -652,7 +652,7 @@
 				}
 			}
 		}
-	examine_ReplUnitTable:
+	examine_ReplUnitTable:;
 	}
 
 	/* second pass to format unreferenced blocks  and init free block count */
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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
