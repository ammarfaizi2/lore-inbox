Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316885AbSFFIKo>; Thu, 6 Jun 2002 04:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSFFIKo>; Thu, 6 Jun 2002 04:10:44 -0400
Received: from pandora.cantech.net.au ([203.26.6.29]:48655 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S316885AbSFFIKd>; Thu, 6 Jun 2002 04:10:33 -0400
Date: Thu, 6 Jun 2002 16:10:04 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: lkml <linux-kernel@vger.kernel.org>, Rasmus Andersen <rasmus@jaquet.dk>
Subject: [PATCH] 2.4.19-pre10 s/Efoo/-Efoo/ drivers/char/rio/*.c UPDATED
Message-ID: <Pine.LNX.4.44.0206061600370.32156-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	This is an update to a patch I send through on Tuseday.
Again it changes "return ENOMEM" for "return -ENOMEM" (and other errors).

It applies cleanly to 2.4.19-pre10.

Yours Tony

Jan 22-26 2003      Linux.Conf.AU       http://conf.linux.org.au/
         The Australian Linux Technical Conference!
--------------------------------------------------------------------------------
diff -X dontdiff -urN linux-2.4.19-pre10.clean/drivers/char/rio/rio_linux.c linux-2.4.19-pre10_rio/drivers/char/rio/rio_linux.c
--- linux-2.4.19-pre10.clean/drivers/char/rio/rio_linux.c	Tue Apr 30 13:22:07 2002
+++ linux-2.4.19-pre10_rio/drivers/char/rio/rio_linux.c	Thu Jun  6 09:23:12 2002
@@ -702,7 +702,7 @@
   func_enter();
 
   /* The "dev" argument isn't used. */
-  rc = -riocontrol (p, 0, cmd, (void *)arg, suser ());
+  rc = riocontrol (p, 0, cmd, (void *)arg, suser ());
 
   func_exit ();
   return rc;
diff -X dontdiff -urN linux-2.4.19-pre10.clean/drivers/char/rio/rioboot.c linux-2.4.19-pre10_rio/drivers/char/rio/rioboot.c
--- linux-2.4.19-pre10.clean/drivers/char/rio/rioboot.c	Tue Apr 30 13:22:07 2002
+++ linux-2.4.19-pre10_rio/drivers/char/rio/rioboot.c	Thu Jun  6 09:23:12 2002
@@ -129,7 +129,7 @@
 		p->RIOError.Error = HOST_FILE_TOO_LARGE;
 		/* restore(oldspl); */
 		func_exit ();
-		return ENOMEM;
+		return -ENOMEM;
 	}
 
 	if ( p->RIOBooting ) {
@@ -137,7 +137,7 @@
 		p->RIOError.Error = BOOT_IN_PROGRESS;
 		/* restore(oldspl); */
 		func_exit ();
-		return EBUSY;
+		return -EBUSY;
 	}
 
 	/*
@@ -165,7 +165,7 @@
 		p->RIOError.Error = COPYIN_FAILED;
 		/* restore(oldspl); */
 		func_exit ();
-		return EFAULT;
+		return -EFAULT;
 	}
 
 	/*
@@ -295,7 +295,7 @@
 			rio_dprintk (RIO_DEBUG_BOOT, "Bin too large\n");
 			p->RIOError.Error = HOST_FILE_TOO_LARGE;
 			func_exit ();
-			return EFBIG;
+			return -EFBIG;
 		}
 		/*
 		** Ensure that the host really is stopped.
@@ -322,7 +322,7 @@
 				rio_dprintk (RIO_DEBUG_BOOT, "No system memory available\n");
 				p->RIOError.Error = NOT_ENOUGH_CORE_FOR_PCI_COPY;
 				func_exit ();
-				return ENOMEM;
+				return -ENOMEM;
 			}
 			bzero(DownCode, rbp->Count);
 
@@ -330,7 +330,7 @@
 				rio_dprintk (RIO_DEBUG_BOOT, "Bad copyin of host data\n");
 				p->RIOError.Error = COPYIN_FAILED;
 				func_exit ();
-				return EFAULT;
+				return -EFAULT;
 			}
 
 			HostP->Copy( DownCode, StartP, rbp->Count );
@@ -341,7 +341,7 @@
 			rio_dprintk (RIO_DEBUG_BOOT, "Bad copyin of host data\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			func_exit ();
-			return EFAULT;
+			return -EFAULT;
 		}
 
 		rio_dprintk (RIO_DEBUG_BOOT, "Copy completed\n");
diff -X dontdiff -urN linux-2.4.19-pre10.clean/drivers/char/rio/riocmd.c linux-2.4.19-pre10_rio/drivers/char/rio/riocmd.c
--- linux-2.4.19-pre10.clean/drivers/char/rio/riocmd.c	Tue Apr 30 13:22:07 2002
+++ linux-2.4.19-pre10_rio/drivers/char/rio/riocmd.c	Thu Jun  6 09:23:12 2002
@@ -98,7 +98,7 @@
 
 	if ( !CmdBlkP ) {
 		rio_dprintk (RIO_DEBUG_CMD, "FOAD RTA: GetCmdBlk failed\n");
-		return ENXIO;
+		return -ENXIO;
 	}
 
 	CmdBlkP->Packet.dest_unit = MapP->ID;
@@ -113,7 +113,7 @@
 
 	if ( RIOQueueCmdBlk( HostP, MapP->ID-1, CmdBlkP) == RIO_FAIL ) {
 		rio_dprintk (RIO_DEBUG_CMD, "FOAD RTA: Failed to queue foad command\n");
-		return EIO;
+		return -EIO;
 	}
 	return 0;
 }
@@ -131,7 +131,7 @@
 
 	if ( !CmdBlkP ) {
 		rio_dprintk (RIO_DEBUG_CMD, "ZOMBIE RTA: GetCmdBlk failed\n");
-		return ENXIO;
+		return -ENXIO;
 	}
 
 	CmdBlkP->Packet.dest_unit = MapP->ID;
@@ -146,7 +146,7 @@
 
 	if ( RIOQueueCmdBlk( HostP, MapP->ID-1, CmdBlkP) == RIO_FAIL ) {
 		rio_dprintk (RIO_DEBUG_CMD, "ZOMBIE RTA: Failed to queue zombie command\n");
-		return EIO;
+		return -EIO;
 	}
 	return 0;
 }
@@ -192,7 +192,7 @@
 			}
 		}
 	}
-	return ENXIO;
+	return -ENXIO;
 }
 
 
@@ -206,7 +206,7 @@
 	if ( copyin( (int)arg, (caddr_t)&IdRta, sizeof(IdRta) ) == COPYFAIL ) {
 		rio_dprintk (RIO_DEBUG_CMD, "RIO_IDENTIFY_RTA copy failed\n");
 		p->RIOError.Error = COPYIN_FAILED;
-		return EFAULT;
+		return -EFAULT;
 	}
 
 	for ( Host = 0 ; Host < p->RIONumHosts; Host++ ) {
@@ -238,7 +238,7 @@
 
 						if ( !CmdBlkP ) {
 							rio_dprintk (RIO_DEBUG_CMD, "IDENTIFY RTA: GetCmdBlk failed\n");
-							return ENXIO;
+							return -ENXIO;
 						}
 		
 						CmdBlkP->Packet.dest_unit = MapP->ID;
@@ -252,7 +252,7 @@
 		
 						if ( RIOQueueCmdBlk( HostP, MapP->ID-1, CmdBlkP) == RIO_FAIL ) {
 							rio_dprintk (RIO_DEBUG_CMD, "IDENTIFY RTA: Failed to queue command\n");
-							return EIO;
+							return -EIO;
 						}
 						return 0;
 					}
@@ -260,7 +260,7 @@
 			}
 		}
 	} 
-	return ENOENT;
+	return -ENOENT;
 }
 
 
@@ -279,17 +279,17 @@
 	if ( copyin( (int)arg, (caddr_t)&KillUnit, sizeof(KillUnit) ) == COPYFAIL ) {
 		rio_dprintk (RIO_DEBUG_CMD, "RIO_KILL_NEIGHBOUR copy failed\n");
 		p->RIOError.Error = COPYIN_FAILED;
-		return EFAULT;
+		return -EFAULT;
 	}
 
 	if ( KillUnit.Link > 3 )
-		return ENXIO;
+		return -ENXIO;
  
 	CmdBlkP = RIOGetCmdBlk();
 
 	if ( !CmdBlkP ) {
 		rio_dprintk (RIO_DEBUG_CMD, "UFOAD: GetCmdBlk failed\n");
-		return ENXIO;
+		return -ENXIO;
 	}
 
 	CmdBlkP->Packet.dest_unit = 0;
@@ -310,7 +310,7 @@
 			if ( RIOQueueCmdBlk( HostP, RTAS_PER_HOST+KillUnit.Link,
 							CmdBlkP) == RIO_FAIL ) {
 				rio_dprintk (RIO_DEBUG_CMD, "UFOAD: Failed queue command\n");
-				return EIO;
+				return -EIO;
 			}
 			return 0;
 		}
@@ -320,14 +320,14 @@
 				CmdBlkP->Packet.dest_unit = ID+1;
 				if ( RIOQueueCmdBlk( HostP, ID, CmdBlkP) == RIO_FAIL ) {
 					rio_dprintk (RIO_DEBUG_CMD, "UFOAD: Failed queue command\n");
-					return EIO;
+					return -EIO;
 				}
 				return 0;
 			}
 		}
 	}
 	RIOFreeCmdBlk( CmdBlkP );
-	return ENXIO;
+	return -ENXIO;
 }
 
 int
@@ -344,7 +344,7 @@
 
 	if ( !CmdBlkP ) {
 		rio_dprintk (RIO_DEBUG_CMD, "SUSPEND BOOT ON RTA: GetCmdBlk failed\n");
-		return ENXIO;
+		return -ENXIO;
 	}
 
 	CmdBlkP->Packet.dest_unit = ID;
@@ -359,7 +359,7 @@
 
 	if ( RIOQueueCmdBlk( HostP, ID - 1, CmdBlkP) == RIO_FAIL ) {
 		rio_dprintk (RIO_DEBUG_CMD, "SUSPEND BOOT ON RTA: Failed to queue iwait command\n");
-		return EIO;
+		return -EIO;
 	}
 	return 0;
 }
diff -X dontdiff -urN linux-2.4.19-pre10.clean/drivers/char/rio/rioctrl.c linux-2.4.19-pre10_rio/drivers/char/rio/rioctrl.c
--- linux-2.4.19-pre10.clean/drivers/char/rio/rioctrl.c	Tue Apr 30 13:22:07 2002
+++ linux-2.4.19-pre10_rio/drivers/char/rio/rioctrl.c	Thu Jun  6 15:27:46 2002
@@ -230,7 +230,7 @@
 						}
 					}
 				} else if (host >= p->RIONumHosts) {
-					return EINVAL;
+					return -EINVAL;
 				} else {
 					if ( p->RIOHosts[host].Flags == RC_RUNNING ) {
 						WWORD(p->RIOHosts[host].ParmMapP->timer , value);
@@ -320,12 +320,12 @@
 							sizeof(SpecialRupCmd)) == COPYFAIL ) {
 					rio_dprintk (RIO_DEBUG_CTRL, "SPECIAL_RUP_CMD copy failed\n");
 					p->RIOError.Error = COPYIN_FAILED;
-		 			return EFAULT;
+		 			return -EFAULT;
 				}
 				CmdBlkP = RIOGetCmdBlk();
 				if ( !CmdBlkP ) {
 					rio_dprintk (RIO_DEBUG_CTRL, "SPECIAL_RUP_CMD GetCmdBlk failed\n");
-					return ENXIO;
+					return -ENXIO;
 				}
 				CmdBlkP->Packet = SpecialRupCmd.Packet;
 				if ( SpecialRupCmd.Host >= p->RIONumHosts )
@@ -345,12 +345,12 @@
 					return rio_RIODebugMemory(RIO_DEBUG_CTRL, arg);
 				else
 #endif
-					return EPERM;
+					return -EPERM;
 
 			case RIO_ALL_MODEM:
 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_ALL_MODEM\n");
 				p->RIOError.Error = IOCTL_COMMAND_UNKNOWN;
-				return EINVAL;
+				return -EINVAL;
 
 			case RIO_GET_TABLE:
 				/*
@@ -365,7 +365,7 @@
 						TOTAL_MAP_ENTRIES*sizeof(struct Map)) == COPYFAIL) {
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_GET_TABLE copy failed\n");
 		 			p->RIOError.Error = COPYOUT_FAILED;
-		 			return EFAULT;
+		 			return -EFAULT;
 				}
 
 				{
@@ -407,13 +407,13 @@
 				if ( !su ) {
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_PUT_TABLE !Root\n");
 		 			p->RIOError.Error = NOT_SUPER_USER;
-		 			return EPERM;
+		 			return -EPERM;
 				}
 				if ( copyin((int)arg, (caddr_t)&p->RIOConnectTable[0], 
 					TOTAL_MAP_ENTRIES*sizeof(struct Map) ) == COPYFAIL ) {
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_PUT_TABLE copy failed\n");
 		 			p->RIOError.Error = COPYIN_FAILED;
-		 			return EFAULT;
+		 			return -EFAULT;
 				}
 /*
 ***********************************
@@ -455,13 +455,13 @@
 				{
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_GET_BINDINGS !Root\n");
 		 			p->RIOError.Error = NOT_SUPER_USER;
-		 			return EPERM;
+		 			return -EPERM;
 				}
 				if (copyout((caddr_t) p->RIOBindTab, (int)arg, 
 						(sizeof(ulong) * MAX_RTA_BINDINGS)) == COPYFAIL ) {
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_GET_BINDINGS copy failed\n");
 		 			p->RIOError.Error = COPYOUT_FAILED;
-		 			return EFAULT;
+		 			return -EFAULT;
 				}
 				return 0;
 
@@ -476,13 +476,13 @@
 				{
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_PUT_BINDINGS !Root\n");
 		 			p->RIOError.Error = NOT_SUPER_USER;
-		 			return EPERM;
+		 			return -EPERM;
 				}
 				if (copyin((int)arg, (caddr_t)&p->RIOBindTab[0], 
 						(sizeof(ulong) * MAX_RTA_BINDINGS))==COPYFAIL ) {
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_PUT_BINDINGS copy failed\n");
 		 			p->RIOError.Error = COPYIN_FAILED;
-		 			return EFAULT;
+		 			return -EFAULT;
 				}
 				return 0;
 
@@ -498,7 +498,7 @@
 					if ( !su ) {
 		 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_BIND_RTA !Root\n");
 		 				p->RIOError.Error = NOT_SUPER_USER;
-		 				return EPERM;
+		 				return -EPERM;
 					}
 					for (Entry = 0; Entry < MAX_RTA_BINDINGS; Entry++) {
 		 				if ((EmptySlot == -1) && (p->RIOBindTab[Entry] == 0L))
@@ -524,7 +524,7 @@
 					else {
 		 				rio_dprintk (RIO_DEBUG_CTRL, "p->RIOBindTab full! - Rta %x not added\n",
 		  					(int) arg);
-		 				return 1;
+		 				return -ENOMEM;
 					}
 					return 0;
 				}
@@ -535,17 +535,17 @@
 				if ((port < 0) || (port > 511)) {
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_RESUME: Bad port number %d\n", port);
 		 			p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-		 			return EINVAL;
+		 			return -EINVAL;
 				}
 				PortP = p->RIOPortp[port];
 				if (!PortP->Mapped) {
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_RESUME: Port %d not mapped\n", port);
 		 			p->RIOError.Error = PORT_NOT_MAPPED_INTO_SYSTEM;
-		 			return EINVAL;
+		 			return -EINVAL;

 				}
 				if (!(PortP->State & (RIO_LOPEN | RIO_MOPEN))) {
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_RESUME: Port %d not open\n", port);
-		 			return EINVAL;
+		 			return -EINVAL;
 				}
 
 				rio_spin_lock_irqsave(&PortP->portSem, flags);
@@ -553,7 +553,7 @@
 										RIO_FAIL) {
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_RESUME failed\n");
 					rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-					return EBUSY;
+					return -EBUSY;
 				}
 				else {
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_RESUME: Port %d resumed\n", port);
@@ -567,13 +567,13 @@
 				if ( !su ) {
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_ASSIGN_RTA !Root\n");
 					p->RIOError.Error = NOT_SUPER_USER;
-					return EPERM;
+					return -EPERM;
 				}
 				if (copyin((int)arg, (caddr_t)&MapEnt, sizeof(MapEnt))
 									== COPYFAIL) {
 					rio_dprintk (RIO_DEBUG_CTRL, "Copy from user space failed\n");
 					p->RIOError.Error = COPYIN_FAILED;
-					return EFAULT;
+					return -EFAULT;
 				}
 				return RIOAssignRta(p, &MapEnt);
 
@@ -582,13 +582,13 @@
 				if ( !su ) {
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_CHANGE_NAME !Root\n");
 					p->RIOError.Error = NOT_SUPER_USER;
-					return EPERM;
+					return -EPERM;
 				}
 				if (copyin((int)arg, (caddr_t)&MapEnt, sizeof(MapEnt))
 						== COPYFAIL) {
 					rio_dprintk (RIO_DEBUG_CTRL, "Copy from user space failed\n");
 					p->RIOError.Error = COPYIN_FAILED;
-					return EFAULT;
+					return -EFAULT;
 				}
 				return RIOChangeName(p, &MapEnt);
 
@@ -597,13 +597,13 @@
 				if ( !su ) {
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_DELETE_RTA !Root\n");
 		 			p->RIOError.Error = NOT_SUPER_USER;
-		 			return EPERM;
+		 			return -EPERM;
 				}
 				if (copyin((int)arg, (caddr_t)&MapEnt, sizeof(MapEnt))
 							== COPYFAIL ) {
 		 			rio_dprintk (RIO_DEBUG_CTRL, "Copy from data space failed\n");
 		 			p->RIOError.Error = COPYIN_FAILED;
-		 			return EFAULT;
+		 			return -EFAULT;
 				}
 				return RIODeleteRta(p, &MapEnt);
 
@@ -627,14 +627,14 @@
 				if (copyout((caddr_t)&p->RIORtaDisCons,(int)arg,
 							sizeof(uint))==COPYFAIL) {
 					p->RIOError.Error = COPYOUT_FAILED;
-					return EFAULT;
+					return -EFAULT;
 				}
 				return 0;
 
 			case RIO_LAST_ERROR:
 				if (copyout((caddr_t)&p->RIOError, (int)arg, 
 						sizeof(struct Error)) ==COPYFAIL )
-					return EFAULT;
+					return -EFAULT;
 				return 0;
 
 			case RIO_GET_LOG:
@@ -643,7 +643,7 @@
 				RIOGetLog(arg);
 				return 0;
 #else
-				return EINVAL;
+				return -EINVAL;
 #endif
 
 			case RIO_GET_MODTYPE:
@@ -651,21 +651,21 @@
 									sizeof(uint)) == COPYFAIL )
 				{
 		 			p->RIOError.Error = COPYIN_FAILED;
-		 			return EFAULT;
+		 			return -EFAULT;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "Get module type for port %d\n", port);
 				if ( port < 0 || port > 511 )
 				{
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_GET_MODTYPE: Bad port number %d\n", port);
 		 			p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-		 			return EINVAL;
+		 			return -EINVAL;
 				}
 				PortP = (p->RIOPortp[port]);
 				if (!PortP->Mapped)
 				{
 		 			rio_dprintk (RIO_DEBUG_CTRL, "RIO_GET_MODTYPE: Port %d not mapped\n", port);
 		 			p->RIOError.Error = PORT_NOT_MAPPED_INTO_SYSTEM;
-		 			return EINVAL;
+		 			return -EINVAL;
 				}
 				/*
 				** Return module type of port
@@ -674,7 +674,7 @@
 				if (copyout((caddr_t)&port, (int)arg, 
 							sizeof(uint)) == COPYFAIL) {
 		 			p->RIOError.Error = COPYOUT_FAILED;
-		 			return EFAULT;
+		 			return -EFAULT;
 				}
 				return(0);
 			/*
@@ -690,7 +690,7 @@
 				if (copyout((caddr_t)&p->RIOBootMode, (int)arg, 
 						sizeof(p->RIOBootMode)) == COPYFAIL) {
 		 			p->RIOError.Error = COPYOUT_FAILED;
-		 			return EFAULT;
+		 			return -EFAULT;
 				}
 				return(0);
 			
@@ -717,24 +717,24 @@
 						== COPYFAIL ) {
 					 p->RIOError.Error = COPYIN_FAILED;
 					 rio_dprintk (RIO_DEBUG_CTRL, "EFAULT");
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if ( PortSetup.From > PortSetup.To || 
 								PortSetup.To >= RIO_PORTS ) {
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
 					 rio_dprintk (RIO_DEBUG_CTRL, "ENXIO");
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				if ( PortSetup.XpCps > p->RIOConf.MaxXpCps ||
 					 PortSetup.XpCps < p->RIOConf.MinXpCps ) {
 					 p->RIOError.Error = XPRINT_CPS_OUT_OF_RANGE;
 					 rio_dprintk (RIO_DEBUG_CTRL, "EINVAL");
-					 return EINVAL;
+					 return -EINVAL;
 				}
 				if ( !p->RIOPortp ) {
 					 cprintf("No p->RIOPortp array!\n");
 					 rio_dprintk (RIO_DEBUG_CTRL, "No p->RIOPortp array!\n");
-					 return EIO;
+					 return -EIO;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "entering loop (%d %d)!\n", PortSetup.From, PortSetup.To);
 				for (loop=PortSetup.From; loop<=PortSetup.To; loop++) {
@@ -800,11 +800,11 @@
 				if (copyin((int)arg, (caddr_t)&PortSetup, sizeof(PortSetup)) 
 							== COPYFAIL ) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if ( PortSetup.From >= RIO_PORTS ) {
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 
 				port = PortSetup.To = PortSetup.From;
@@ -827,7 +827,7 @@
 				if ( copyout((caddr_t)&PortSetup,(int)arg,sizeof(PortSetup))
 														==COPYFAIL ) {
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return retval;
 
@@ -836,11 +836,11 @@
 				if (copyin( (int)arg, (caddr_t)&PortParams,
 					sizeof(struct PortParams)) == COPYFAIL) {
 					p->RIOError.Error = COPYIN_FAILED;
-					return EFAULT;
+					return -EFAULT;
 				}
 				if (PortParams.Port >= RIO_PORTS) {
 					p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					return ENXIO;
+					return -ENXIO;
 				}
 				PortP = (p->RIOPortp[PortParams.Port]);
 				PortParams.Config = PortP->Config;
@@ -850,7 +850,7 @@
 				if (copyout((caddr_t)&PortParams, (int)arg, 
 						sizeof(struct PortParams)) == COPYFAIL ) {
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return retval;
 
@@ -859,11 +859,11 @@
 				if (copyin((int)arg, (caddr_t)&PortTty, sizeof(struct PortTty)) 
 						== COPYFAIL) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if ( PortTty.port >= RIO_PORTS ) {
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 
 				rio_dprintk (RIO_DEBUG_CTRL, "Port %d\n", PortTty.port);
@@ -877,7 +877,7 @@
 				if (copyout((caddr_t)&PortTty, (int)arg, 
 							sizeof(struct PortTty)) == COPYFAIL) {
 					p->RIOError.Error = COPYOUT_FAILED;
-					return EFAULT;
+					return -EFAULT;
 				}
 				return retval;
 
@@ -885,12 +885,12 @@
 				if (copyin((int)arg, (caddr_t)&PortTty, 
 						sizeof(struct PortTty)) == COPYFAIL) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "Set port %d tty\n", PortTty.port);
 				if (PortTty.port >= (ushort) RIO_PORTS) {
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				PortP = (p->RIOPortp[PortTty.port]);
 #if 0
@@ -910,11 +910,11 @@
 				if ( copyin((int)arg, (caddr_t)&PortParams, sizeof(PortParams))
 					== COPYFAIL ) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if (PortParams.Port >= (ushort) RIO_PORTS) {
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				PortP = (p->RIOPortp[PortParams.Port]);
 		 		rio_spin_lock_irqsave(&PortP->portSem, flags);
@@ -927,11 +927,11 @@
 				if ( copyin((int)arg, (caddr_t)&portStats, 
 						sizeof(struct portStats)) == COPYFAIL ) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if ( portStats.port >= RIO_PORTS ) {
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				PortP = (p->RIOPortp[portStats.port]);
 				portStats.gather = PortP->statsGather;
@@ -943,7 +943,7 @@
 				if ( copyout((caddr_t)&portStats, (int)arg, 
 							sizeof(struct portStats)) == COPYFAIL ) {
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return retval;
 
@@ -952,7 +952,7 @@
 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_RESET_PORT_STATS\n");
 				if ( port >= RIO_PORTS ) {
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				PortP = (p->RIOPortp[port]);
 				rio_spin_lock_irqsave(&PortP->portSem, flags);
@@ -969,11 +969,11 @@
 				if ( copyin( (int)arg, (caddr_t)&portStats, 
 						sizeof(struct portStats)) == COPYFAIL ) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if ( portStats.port >= RIO_PORTS ) {
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				PortP = (p->RIOPortp[portStats.port]);
 				rio_spin_lock_irqsave(&PortP->portSem, flags);
@@ -992,7 +992,7 @@
 						sizeof(struct DbInf)*(num+1))==COPYFAIL) {
 						rio_dprintk (RIO_DEBUG_CTRL, "ReadLevels Copy failed\n");
 						p->RIOError.Error = COPYOUT_FAILED;
-						return EFAULT;
+						return -EFAULT;
 					 }
 					 rio_dprintk (RIO_DEBUG_CTRL, "%d levels to copied\n",num);
 					 return retval;
@@ -1004,7 +1004,7 @@
 				if (copyout((caddr_t)&p->RIOConf, (int)arg, 
 							sizeof(struct Conf)) ==COPYFAIL ) {
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return retval;
 
@@ -1012,12 +1012,12 @@
 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_SET_CONFIG\n");
 				if ( !su ) {
 					 p->RIOError.Error = NOT_SUPER_USER;
-					 return EPERM;
+					 return -EPERM;
 				}
 				if ( copyin((int)arg, (caddr_t)&p->RIOConf, sizeof(struct Conf) )
 						==COPYFAIL ) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				/*
 				** move a few value around
@@ -1030,13 +1030,13 @@
 
 			case RIO_START_POLLER:
 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_START_POLLER\n");
-				return EINVAL;
+				return -EINVAL;
 
 			case RIO_STOP_POLLER:
 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_STOP_POLLER\n");
 				if ( !su ) {
 					 p->RIOError.Error = NOT_SUPER_USER;
-					 return EPERM;
+					 return -EPERM;
 				}
 				p->RIOPolling = NOT_POLLING;
 				return retval;
@@ -1047,13 +1047,13 @@
 				if ( copyin( (int)arg, (caddr_t)&DebugCtrl, sizeof(DebugCtrl) )
 							==COPYFAIL ) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if ( DebugCtrl.SysPort == NO_PORT ) {
 					if ( cmd == RIO_SETDEBUG ) {
 						if ( !su ) {
 							p->RIOError.Error = NOT_SUPER_USER;
-							return EPERM;
+							return -EPERM;
 						}
 						p->rio_debug = DebugCtrl.Debug;
 						p->RIODebugWait = DebugCtrl.Wait;
@@ -1070,7 +1070,7 @@
 							rio_dprintk (RIO_DEBUG_CTRL, "RIO_SET/GET DEBUG: bad port number %d\n",
 									DebugCtrl.SysPort);
 						 	p->RIOError.Error = COPYOUT_FAILED;
-						 	return EFAULT;
+						 	return -EFAULT;
 						}
 					}
 				}
@@ -1079,12 +1079,12 @@
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_SET/GET DEBUG: bad port number %d\n",
 									DebugCtrl.SysPort);
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				else if ( cmd == RIO_SETDEBUG ) {
 					if ( !su ) {
 						p->RIOError.Error = NOT_SUPER_USER;
-						return EPERM;
+						return -EPERM;
 					}
 					rio_spin_lock_irqsave(&PortP->portSem, flags);
 					p->RIOPortp[DebugCtrl.SysPort]->Debug = DebugCtrl.Debug;
@@ -1100,7 +1100,7 @@
 								sizeof(DebugCtrl))==COPYFAIL ) {
 						rio_dprintk (RIO_DEBUG_CTRL, "RIO_GETDEBUG: Bad copy to user space\n");
 						p->RIOError.Error = COPYOUT_FAILED;
-						return EFAULT;
+						return -EFAULT;
 					}
 				}
 				return retval;
@@ -1118,7 +1118,7 @@
 				{
 					 rio_dprintk (RIO_DEBUG_CTRL,  "RIO_VERSID: Bad copy to user space (host=%d)\n", Host);
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return retval;
 
@@ -1138,7 +1138,7 @@
 						(int)arg, MAX_VERSION_LEN ) == COPYFAIL ) {
 					 rio_dprint(RIO_DEBUG_CTRL, ("RIO_VERSID: Bad copy to user space\n",Host));
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return retval;
 			**
@@ -1155,7 +1155,7 @@
 							sizeof(p->RIONumHosts) )==COPYFAIL ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_NUM_HOSTS: Bad copy to user space\n");
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return retval;
 
@@ -1167,7 +1167,7 @@
 				if ( !su ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_FOAD: Not super user\n");
 					 p->RIOError.Error = NOT_SUPER_USER;
-					 return EPERM;
+					 return -EPERM;
 				}
 				p->RIOHalted = 1;
 				p->RIOSystemUp = 0;
@@ -1217,13 +1217,13 @@
 				if ( !su ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_DOWNLOAD: Not super user\n");
 					 p->RIOError.Error = NOT_SUPER_USER;
-					 return EPERM;
+					 return -EPERM;
 				}
 				if ( copyin((int)arg, (caddr_t)&DownLoad, 
 							sizeof(DownLoad) )==COPYFAIL ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_DOWNLOAD: Copy in from user space failed\n");
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "Copied in download code for product code 0x%x\n",
 				    DownLoad.ProductCode);
@@ -1235,7 +1235,7 @@
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_DOWNLOAD: Bad product code %d passed\n",
 							DownLoad.ProductCode);
 					 p->RIOError.Error = NO_SUCH_PRODUCT;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				/*
 				** do something!
@@ -1257,7 +1257,7 @@
 						rio_dprintk (RIO_DEBUG_CTRL, 
 							"RIO_HOST_REQ: Copy in from user space failed\n");
 						p->RIOError.Error = COPYIN_FAILED;
-						return EFAULT;
+						return -EFAULT;
 					}
 					/*
 					** Fetch the parmmap
@@ -1267,7 +1267,7 @@
 								(int)arg, sizeof(PARM_MAP) )==COPYFAIL ) {
 						p->RIOError.Error = COPYOUT_FAILED;
 						rio_dprintk (RIO_DEBUG_CTRL, "RIO_PARMS: Copy out to user space failed\n");
-						return EFAULT;
+						return -EFAULT;
 					}
 				}
 				return retval;
@@ -1278,13 +1278,13 @@
 							sizeof(HostReq) )==COPYFAIL ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_REQ: Copy in from user space failed\n");
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if ( HostReq.HostNum >= p->RIONumHosts ) {
 					 p->RIOError.Error = HOST_NUMBER_OUT_OF_RANGE;
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_REQ: Illegal host number %d\n",
 							HostReq.HostNum);
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "Request for host %d\n", HostReq.HostNum);
 
@@ -1292,7 +1292,7 @@
 					(int)HostReq.HostP,sizeof(struct Host) ) == COPYFAIL) {
 					p->RIOError.Error = COPYOUT_FAILED;
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_REQ: Bad copy to user space\n");
-					return EFAULT;
+					return -EFAULT;
 				}
 				return retval;
 
@@ -1302,13 +1302,13 @@
 								sizeof(HostDpRam) )==COPYFAIL ) {
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_DPRAM: Copy in from user space failed\n");
 					p->RIOError.Error = COPYIN_FAILED;
-					return EFAULT;
+					return -EFAULT;
 				}
 				if ( HostDpRam.HostNum >= p->RIONumHosts ) {
 					p->RIOError.Error = HOST_NUMBER_OUT_OF_RANGE;
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_DPRAM: Illegal host number %d\n",
 										HostDpRam.HostNum);
-					return ENXIO;
+					return -ENXIO;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "Request for host %d\n", HostDpRam.HostNum);
 
@@ -1322,7 +1322,7 @@
 							sizeof(struct DpRam) ) == COPYFAIL ) {
 						p->RIOError.Error = COPYOUT_FAILED;
 						rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_DPRAM: Bad copy to user space\n");
-						return EFAULT;
+						return -EFAULT;
 					}
 				}
 				else if (copyout((caddr_t)p->RIOHosts[HostDpRam.HostNum].Caddr,
@@ -1330,7 +1330,7 @@
 						sizeof(struct DpRam) ) == COPYFAIL ) {
 					 p->RIOError.Error = COPYOUT_FAILED;
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_DPRAM: Bad copy to user space\n");
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return retval;
 
@@ -1339,7 +1339,7 @@
 				if ( (int)arg < 0 || (int)arg > 511 ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_SET_BUSY: Bad port number %d\n",(int)arg);
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return EINVAL;
+					 return -EINVAL;
 				}
 				rio_spin_lock_irqsave(&PortP->portSem, flags);
 				p->RIOPortp[(int)arg]->State |= RIO_BUSY;
@@ -1356,14 +1356,14 @@
 					sizeof(PortReq) )==COPYFAIL ) {
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_PORT: Copy in from user space failed\n");
 					p->RIOError.Error = COPYIN_FAILED;
-					return EFAULT;
+					return -EFAULT;
 				}
 
 				if (PortReq.SysPort >= RIO_PORTS) { /* SysPort is unsigned */
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_PORT: Illegal port number %d\n",
 											PortReq.SysPort);
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "Request for port %d\n", PortReq.SysPort);
 				if (copyout((caddr_t)p->RIOPortp[PortReq.SysPort], 
@@ -1371,7 +1371,7 @@
 								sizeof(struct Port) ) == COPYFAIL) {
 					 p->RIOError.Error = COPYOUT_FAILED;
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_PORT: Bad copy to user space\n");
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return retval;
 
@@ -1385,19 +1385,19 @@
 						sizeof(RupReq) )==COPYFAIL ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_RUP: Copy in from user space failed\n");
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if (RupReq.HostNum >= p->RIONumHosts) { /* host is unsigned */
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_RUP: Illegal host number %d\n",
 								RupReq.HostNum);
 					 p->RIOError.Error = HOST_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 				if ( RupReq.RupNum >= MAX_RUP+LINKS_PER_UNIT ) { /* eek! */
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_RUP: Illegal rup number %d\n",
 							RupReq.RupNum);
 					 p->RIOError.Error = RUP_NUMBER_OUT_OF_RANGE;
-					 return EINVAL;
+					 return -EINVAL;
 				}
 				HostP = &p->RIOHosts[RupReq.HostNum];
 
@@ -1405,7 +1405,7 @@
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_RUP: Host %d not running\n",
 							RupReq.HostNum);
 					 p->RIOError.Error = HOST_NOT_RUNNING;
-					 return EIO;
+					 return -EIO;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "Request for rup %d from host %d\n",
 						RupReq.RupNum,RupReq.HostNum);
@@ -1414,7 +1414,7 @@
 					(int)RupReq.RupP,sizeof(struct RUP) ) == COPYFAIL) {
 					p->RIOError.Error = COPYOUT_FAILED;
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_RUP: Bad copy to user space\n");
-					return EFAULT;
+					return -EFAULT;
 				}
 				return retval;
 
@@ -1428,19 +1428,19 @@
 					sizeof(LpbReq) )==COPYFAIL ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_LPB: Bad copy from user space\n");
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if (LpbReq.Host >= p->RIONumHosts) { /* host is unsigned */
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_LPB: Illegal host number %d\n",
 							LpbReq.Host);
 					p->RIOError.Error = HOST_NUMBER_OUT_OF_RANGE;
-					return ENXIO;
+					return -ENXIO;
 				}
 				if ( LpbReq.Link >= LINKS_PER_UNIT ) { /* eek! */
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_LPB: Illegal link number %d\n",
 							LpbReq.Link);
 					 p->RIOError.Error = LINK_NUMBER_OUT_OF_RANGE;
-					 return EINVAL;
+					 return -EINVAL;
 				}
 				HostP = &p->RIOHosts[LpbReq.Host];
 
@@ -1448,7 +1448,7 @@
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_LPB: Host %d not running\n",
 						LpbReq.Host );
 					 p->RIOError.Error = HOST_NOT_RUNNING;
-					 return EIO;
+					 return -EIO;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "Request for lpb %d from host %d\n",
 					LpbReq.Link, LpbReq.Host);
@@ -1457,7 +1457,7 @@
 					(int)LpbReq.LpbP,sizeof(struct LPB) ) == COPYFAIL) {
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_HOST_LPB: Bad copy to user space\n");
 					p->RIOError.Error = COPYOUT_FAILED;
-					return EFAULT;
+					return -EFAULT;
 				}
 				return retval;
 
@@ -1483,7 +1483,7 @@
 			case RIO_SIGNALS_ON:
 				if ( p->RIOSignalProcess ) {
 					 p->RIOError.Error = SIGNALS_ALREADY_SET;
-					 return EBUSY;
+					 return -EBUSY;
 				}
 				p->RIOSignalProcess = getpid();
 				p->RIOPrintDisabled = DONT_PRINT;
@@ -1492,7 +1492,7 @@
 			case RIO_SIGNALS_OFF:
 				if ( p->RIOSignalProcess != getpid() ) {
 					 p->RIOError.Error = NOT_RECEIVING_PROCESS;
-					 return EPERM;
+					 return -EPERM;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "Clear signal process to zero\n");
 				p->RIOSignalProcess = 0;
@@ -1531,7 +1531,7 @@
 				if ( port < 0 || port > 511 ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "Baud rate mapping: Bad port number %d\n", port);
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return EINVAL;
+					 return -EINVAL;
 				}
 				rio_spin_lock_irqsave(&PortP->portSem, flags);
 				switch( cmd )
@@ -1554,7 +1554,7 @@
 
 			case RIO_STREAM_INFO:
 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_STREAM_INFO\n");
-				return EINVAL;
+				return -EINVAL;
 
 			case RIO_SEND_PACKET:
 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_SEND_PACKET\n");
@@ -1562,11 +1562,11 @@
 									sizeof(SendPack) )==COPYFAIL ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_SEND_PACKET: Bad copy from user space\n");
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				if ( SendPack.PortNum >= 128 ) {
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return ENXIO;
+					 return -ENXIO;
 				}
 
 				PortP = p->RIOPortp[SendPack.PortNum];
@@ -1575,7 +1575,7 @@
 				if ( !can_add_transmit(&PacketP,PortP) ) {
 					 p->RIOError.Error = UNIT_IS_IN_USE;
 					 rio_spin_unlock_irqrestore( &PortP->portSem , flags);
-					 return ENOSPC;
+					 return -ENOSPC;
 				}
 
 				for ( loop=0; loop<(ushort)(SendPack.Len & 127); loop++ )
@@ -1595,19 +1595,19 @@
 			case RIO_NO_MESG:
 				if ( su )
 					 p->RIONoMessage = 1;
-				return su ? 0 : EPERM;
+				return su ? 0 : -EPERM;
 
 			case RIO_MESG:
 				if ( su )
 					p->RIONoMessage = 0;
-				return su ? 0 : EPERM;
+				return su ? 0 : -EPERM;
 
 			case RIO_WHAT_MESG:
 				if ( copyout( (caddr_t)&p->RIONoMessage, (int)arg, 
 					sizeof(p->RIONoMessage) )==COPYFAIL ) {
 					rio_dprintk (RIO_DEBUG_CTRL, "RIO_WHAT_MESG: Bad copy to user space\n");
 					p->RIOError.Error = COPYOUT_FAILED;
-					return EFAULT;
+					return -EFAULT;
 				}
 				return 0;
 
@@ -1615,19 +1615,19 @@
 				if (copyin((int)arg, (caddr_t)&SubCmd, 
 						sizeof(struct SubCmdStruct)) == COPYFAIL) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_MEM_DUMP host %d rup %d addr %x\n", 
 						SubCmd.Host, SubCmd.Rup, SubCmd.Addr);
 
 				if (SubCmd.Rup >= MAX_RUP+LINKS_PER_UNIT ) {
 					 p->RIOError.Error = RUP_NUMBER_OUT_OF_RANGE;
-					 return EINVAL;
+					 return -EINVAL;
 				}
 
 				if (SubCmd.Host >= p->RIONumHosts ) {
 					 p->RIOError.Error = HOST_NUMBER_OUT_OF_RANGE;
-					 return EINVAL;
+					 return -EINVAL;
 				}
 
 				port = p->RIOHosts[SubCmd.Host].
@@ -1640,7 +1640,7 @@
 				if ( RIOPreemptiveCmd(p,  PortP, MEMDUMP ) == RIO_FAIL ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_MEM_DUMP failed\n");
 					 rio_spin_unlock_irqrestore( &PortP->portSem , flags);
-					 return EBUSY;
+					 return -EBUSY;
 				}
 				else
 					 PortP->State |= RIO_BUSY;
@@ -1650,20 +1650,20 @@
 							MEMDUMP_SIZE) == COPYFAIL ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_MEM_DUMP copy failed\n");
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return 0;
 
 			case RIO_TICK:
 				if ((int)arg < 0 || (int)arg >= p->RIONumHosts)
-					 return EINVAL;
+					 return -EINVAL;
 				rio_dprintk (RIO_DEBUG_CTRL, "Set interrupt for host %d\n", (int)arg);
 				WBYTE(p->RIOHosts[(int)arg].SetInt , 0xff);
 				return 0;
 
 			case RIO_TOCK:
 				if ((int)arg < 0 || (int)arg >= p->RIONumHosts)
-					 return EINVAL;
+					 return -EINVAL;
 				rio_dprintk (RIO_DEBUG_CTRL, "Clear interrupt for host %d\n", (int)arg);
 				WBYTE((p->RIOHosts[(int)arg].ResetInt) , 0xff);
 				return 0;
@@ -1674,7 +1674,7 @@
 				if (copyout((caddr_t)&p->RIOReadCheck,(int)arg,
 							sizeof(uint))== COPYFAIL) {
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return 0;
 
@@ -1682,7 +1682,7 @@
 				if (copyin((int)arg, (caddr_t)&SubCmd, 
 							sizeof(struct SubCmdStruct)) == COPYFAIL) {
 					 p->RIOError.Error = COPYIN_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				rio_dprintk (RIO_DEBUG_CTRL, "RIO_READ_REGISTER host %d rup %d port %d reg %x\n", 
 						SubCmd.Host, SubCmd.Rup, SubCmd.Port, SubCmd.Addr);
@@ -1691,17 +1691,17 @@
 					 rio_dprintk (RIO_DEBUG_CTRL, "Baud rate mapping: Bad port number %d\n", 
 								SubCmd.Port);
 					 p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
-					 return EINVAL;
+					 return -EINVAL;
 				}
 
 				if (SubCmd.Rup >= MAX_RUP+LINKS_PER_UNIT ) {
 					 p->RIOError.Error = RUP_NUMBER_OUT_OF_RANGE;
-					 return EINVAL;
+					 return -EINVAL;
 				}
 
 				if (SubCmd.Host >= p->RIONumHosts ) {
 					 p->RIOError.Error = HOST_NUMBER_OUT_OF_RANGE;
-					 return EINVAL;
+					 return -EINVAL;
 				}
 
 				port = p->RIOHosts[SubCmd.Host].
@@ -1713,7 +1713,7 @@
 				if (RIOPreemptiveCmd(p, PortP, READ_REGISTER) == RIO_FAIL) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_READ_REGISTER failed\n");
 					 rio_spin_unlock_irqrestore( &PortP->portSem , flags);
-					 return EBUSY;
+					 return -EBUSY;
 				}
 				else
 					 PortP->State |= RIO_BUSY;
@@ -1723,7 +1723,7 @@
 							sizeof(uint)) == COPYFAIL ) {
 					 rio_dprintk (RIO_DEBUG_CTRL, "RIO_READ_REGISTER copy failed\n");
 					 p->RIOError.Error = COPYOUT_FAILED;
-					 return EFAULT;
+					 return -EFAULT;
 				}
 				return 0;
 				/*
@@ -1750,7 +1750,7 @@
 							return (int)arg;
 					}
 					rio_dprintk (RIO_DEBUG_CTRL, "MAKE Device is called\n");
-					return EINVAL;
+					return -EINVAL;
 				}
 				/*
 				** rio_minor: given a dev_t from a stat() call, return
@@ -1780,7 +1780,7 @@
 	p->RIOError.Error = IOCTL_COMMAND_UNKNOWN;
 
 	func_exit ();
-	return EINVAL;
+	return -EINVAL;
 }
 
 /*
diff -X dontdiff -urN linux-2.4.19-pre10.clean/drivers/char/rio/riotable.c linux-2.4.19-pre10_rio/drivers/char/rio/riotable.c
--- linux-2.4.19-pre10.clean/drivers/char/rio/riotable.c	Tue Apr 30 13:22:09 2002
+++ linux-2.4.19-pre10_rio/drivers/char/rio/riotable.c	Thu Jun  6 09:23:13 2002
@@ -125,7 +125,7 @@
 	rio_dprintk (RIO_DEBUG_TABLE, "RIONewTable: entering(1)\n"); 
 	if ( p->RIOSystemUp ) {		/* (1) */
 		p->RIOError.Error = HOST_HAS_ALREADY_BEEN_BOOTED;
-		return EBUSY;
+		return -EBUSY;
 	}
 
 	p->RIOError.Error = NOTHING_WRONG_AT_ALL;
@@ -147,7 +147,7 @@
 				if ( *cptr<' ' || *cptr>'~' ) {
 					p->RIOError.Error = BAD_CHARACTER_IN_NAME;
 					p->RIOError.Entry = Entry;
-					return ENXIO;
+					return -ENXIO;
 				}
 				cptr++;
 			}
@@ -169,7 +169,7 @@
 				rio_dprintk (RIO_DEBUG_TABLE, "%s pretending to be empty but isn't\n",MapP->Name);
 				p->RIOError.Error = TABLE_ENTRY_ISNT_PROPERLY_NULL;
 				p->RIOError.Entry = Entry;
-				return ENXIO;
+				return -ENXIO;
 			}
 			rio_dprintk (RIO_DEBUG_TABLE, "!RIO: Daemon: test (3) passes\n");
 			continue;
@@ -207,14 +207,14 @@
 							MapP->Name);
 				p->RIOError.Error		 = ZERO_RTA_ID;
 				p->RIOError.Entry = Entry;
-				return ENXIO;
+				return -ENXIO;
 			}
 			if ( MapP->ID > MAX_RUP ) {
 				rio_dprintk (RIO_DEBUG_TABLE, "RIO: RTA %s has been allocated an illegal ID %d\n",
 							MapP->Name, MapP->ID);
 				p->RIOError.Error = ID_NUMBER_OUT_OF_RANGE;
 				p->RIOError.Entry = Entry;
-				return ENXIO;
+				return -ENXIO;
 			}
 			for ( SubEnt=0; SubEnt<Entry; SubEnt++ ) {
 				if ( MapP->HostUniqueNum == 
@@ -225,7 +225,7 @@
 					p->RIOError.Error = DUPLICATED_RTA_ID;
 					p->RIOError.Entry = Entry;
 					p->RIOError.Other = SubEnt;
-					return ENXIO;
+					return -ENXIO;
 				}
 				/*
 				** If the RtaUniqueNum is the same, it may be looking at both
@@ -240,7 +240,7 @@
 					p->RIOError.Error = DUPLICATE_UNIQUE_NUMBER;
 					p->RIOError.Entry = Entry;
 					p->RIOError.Other = SubEnt;
-					return ENXIO;
+					return -ENXIO;
 				}
 			}
 			rio_dprintk (RIO_DEBUG_TABLE, "RIONewTable: entering(7a)\n"); 
@@ -250,7 +250,7 @@
 					(int)MapP->SysPort,MapP->Name, PORTS_PER_RTA);
 				p->RIOError.Error = TTY_NUMBER_OUT_OF_RANGE;
 				p->RIOError.Entry = Entry;
-				return ENXIO;
+				return -ENXIO;
 			}
 			rio_dprintk (RIO_DEBUG_TABLE, "RIONewTable: entering(7b)\n"); 
 			/* (7b) */
@@ -259,7 +259,7 @@
 							(int)MapP->SysPort, MapP->Name);
 				p->RIOError.Error = TTY_NUMBER_OUT_OF_RANGE;
 				p->RIOError.Entry = Entry;
-				return ENXIO;
+				return -ENXIO;
 			}
 			for ( SubEnt=0; SubEnt<Entry; SubEnt++ ) {
 				if ( p->RIOConnectTable[SubEnt].Flags & RTA16_SECOND_SLOT )
@@ -275,7 +275,7 @@
 						p->RIOError.Error = TTY_NUMBER_IN_USE;
 						p->RIOError.Entry = Entry;
 						p->RIOError.Other = SubEnt;
-						return ENXIO;
+						return -ENXIO;
 					}
 					rio_dprintk (RIO_DEBUG_TABLE, "RIONewTable: entering(9)\n"); 
 					if (RIOStrCmp(MapP->Name,
@@ -284,7 +284,7 @@
 						p->RIOError.Error = NAME_USED_TWICE;
 						p->RIOError.Entry = Entry;
 						p->RIOError.Other = SubEnt;
-						return ENXIO;
+						return -ENXIO;
 					}
 				}
 			}
@@ -296,14 +296,14 @@
 					MapP->Name);
 				p->RIOError.Error = HOST_ID_NOT_ZERO;
 				p->RIOError.Entry = Entry;
-				return ENXIO;
+				return -ENXIO;
 			}
 			if ( MapP->SysPort != NO_PORT ) {
 				rio_dprintk (RIO_DEBUG_TABLE, "RIO: HOST %s has been allocated port numbers!\n",
 					MapP->Name);
 				p->RIOError.Error = HOST_SYSPORT_BAD;
 				p->RIOError.Entry = Entry;
-				return ENXIO;
+				return -ENXIO;
 			}
 		}
 	}
@@ -530,7 +530,7 @@
 						rio_dprintk (RIO_DEBUG_TABLE, "Entry is in use and cannot be deleted!\n");
 						p->RIOError.Error = UNIT_IS_IN_USE;
 						rio_spin_unlock_irqrestore( &HostP->HostLock, lock_flags);
-						return EBUSY;
+						return -EBUSY;
 					}
 				}
 				/*
@@ -629,7 +629,7 @@
 
 	rio_dprintk (RIO_DEBUG_TABLE, "Couldn't find entry to be deleted\n");
 	p->RIOError.Error = COULDNT_FIND_ENTRY;
-	return ENXIO;
+	return -ENXIO;
 }
 
 int RIOAssignRta( struct rio_info *p, struct Map *MapP )
@@ -649,25 +649,25 @@
     {
 	rio_dprintk (RIO_DEBUG_TABLE, "Bad ID in map entry!\n");
 	p->RIOError.Error = ID_NUMBER_OUT_OF_RANGE;
-	return EINVAL;
+	return -EINVAL;
     }
     if (MapP->RtaUniqueNum == 0)
     {
 	rio_dprintk (RIO_DEBUG_TABLE, "Rta Unique number zero!\n");
 	p->RIOError.Error = RTA_UNIQUE_NUMBER_ZERO;
-	return EINVAL;
+	return -EINVAL;
     }
     if ( (MapP->SysPort != NO_PORT) && (MapP->SysPort % PORTS_PER_RTA) )
     {
 	rio_dprintk (RIO_DEBUG_TABLE, "Port %d not multiple of %d!\n",(int)MapP->SysPort,PORTS_PER_RTA);
 	p->RIOError.Error = TTY_NUMBER_OUT_OF_RANGE;
-	return EINVAL;
+	return -EINVAL;
     }
     if ( (MapP->SysPort != NO_PORT) && (MapP->SysPort >= RIO_PORTS) )
     {
 	rio_dprintk (RIO_DEBUG_TABLE, "Port %d not valid!\n",(int)MapP->SysPort);
 	p->RIOError.Error = TTY_NUMBER_OUT_OF_RANGE;
-	return EINVAL;
+	return -EINVAL;
     }
 
     /*
@@ -681,7 +681,7 @@
     {
 	rio_dprintk (RIO_DEBUG_TABLE, "Name entry contains non-printing characters!\n");
 	p->RIOError.Error = BAD_CHARACTER_IN_NAME;
-	return EINVAL;
+	return -EINVAL;
     }
     sptr++;
     }
@@ -693,7 +693,7 @@
 	    if ( (p->RIOHosts[host].Flags & RUN_STATE) != RC_RUNNING )
 	    {
 		p->RIOError.Error = HOST_NOT_RUNNING;
-		return ENXIO;
+		return -ENXIO;
 	    }
 
 	    /*
@@ -720,7 +720,7 @@
 		if (RIOFindFreeID(p, &p->RIOHosts[host], &nNewID, NULL) != 0)
 		{
 		    p->RIOError.Error = COULDNT_FIND_ENTRY;
-		    return EBUSY;
+		    return -EBUSY;
 		}
 		MapP->ID = (ushort)nNewID + 1;
 		rio_dprintk (RIO_DEBUG_TABLE, "Allocated ID %d for this new RTA.\n", MapP->ID);
@@ -744,7 +744,7 @@
 		    if (unit == MAX_RUP)
 		    {
 			p->RIOError.Error = COULDNT_FIND_ENTRY;
-			return EBUSY;
+			return -EBUSY;
 		    }
 		    HostMapP->Flags |= RTA16_SECOND_SLOT;
 		    HostMapP->ID2 = MapP->ID2 = p->RIOHosts[host].Mapping[unit].ID;
@@ -761,7 +761,7 @@
 	    {
 		rio_dprintk (RIO_DEBUG_TABLE, "Map table slot for ID %d is already in use.\n", MapP->ID);
 		p->RIOError.Error = ID_ALREADY_IN_USE;
-		return EBUSY;
+		return -EBUSY;
 	    }
 
 	    /*
@@ -802,7 +802,7 @@
     }
     p->RIOError.Error = UNKNOWN_HOST_NUMBER;
     rio_dprintk (RIO_DEBUG_TABLE, "Unknown host %x\n", MapP->HostUniqueNum);
-    return ENXIO;
+    return -ENXIO;
 }
 
 
@@ -1017,7 +1017,7 @@
 	if ( MapP->ID > MAX_RUP ) {
 		rio_dprintk (RIO_DEBUG_TABLE, "Bad ID in map entry!\n");
 		p->RIOError.Error = ID_NUMBER_OUT_OF_RANGE;
-		return EINVAL;
+		return -EINVAL;
 	}
 
 	MapP->Name[MAX_NAME_LEN-1] = '\0';
@@ -1027,7 +1027,7 @@
 		if ( *sptr<' ' || *sptr>'~' ) {
 			rio_dprintk (RIO_DEBUG_TABLE, "Name entry contains non-printing characters!\n");
 			p->RIOError.Error = BAD_CHARACTER_IN_NAME;
-			return EINVAL;
+			return -EINVAL;
 		}
 		sptr++;
 	}
@@ -1036,7 +1036,7 @@
 		if ( MapP->HostUniqueNum == p->RIOHosts[host].UniqueNum ) {
 			if ( (p->RIOHosts[host].Flags & RUN_STATE) != RC_RUNNING ) {
 				p->RIOError.Error = HOST_NOT_RUNNING;
-				return ENXIO;
+				return -ENXIO;
 			}
 			if ( MapP->ID==0 ) {
 				CCOPY( MapP->Name, p->RIOHosts[host].Name, MAX_NAME_LEN );
@@ -1047,7 +1047,7 @@
 
 			if ( HostMapP->RtaUniqueNum != MapP->RtaUniqueNum ) {
 				p->RIOError.Error = RTA_NUMBER_WRONG;
-				return ENXIO;
+				return -ENXIO;
 			}
 			CCOPY( MapP->Name, HostMapP->Name, MAX_NAME_LEN );
 			return 0;
@@ -1055,5 +1055,5 @@
 	}
 	p->RIOError.Error = UNKNOWN_HOST_NUMBER;
 	rio_dprintk (RIO_DEBUG_TABLE, "Unknown host %x\n", MapP->HostUniqueNum);
-	return ENXIO;
+	return -ENXIO;
 }

