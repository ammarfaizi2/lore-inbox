Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265662AbSJSTHR>; Sat, 19 Oct 2002 15:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbSJSTHR>; Sat, 19 Oct 2002 15:07:17 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29447 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265660AbSJSTHD>; Sat, 19 Oct 2002 15:07:03 -0400
Date: Sat, 19 Oct 2002 15:12:36 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mike Anderson <andmike@us.ibm.com>
cc: andy barlak <andyb@island.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.5.43 scsi _eh_ buslogic
In-Reply-To: <20021018224311.GB1066@beaverton.ibm.com>
Message-ID: <Pine.LNX.3.96.1021019150909.29078A-300000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1170656797-689491880-1035054756=:29078"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1170656797-689491880-1035054756=:29078
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 18 Oct 2002, Mike Anderson wrote:

> Andy,
> 	From looking at the driver it looks like the locking had been
> update to 2.5, but that the driver error handling has not been updated.
> scsi_obsolete.c has not existed in the 2.5 view for a while.
> 
> I have cc'd linux-scsi as someone on the list might be able to
> give more information on the status of the driver.
> 
> So if you where previously getting timeouts / errors on probe in 2.4 the
> older error handler might have been clearing things up and now nothing
> is being called.
> 
> We should remove the older error handling interfaces as they are not
> called and possibly print a warning if a driver loads with no error
> handling functions set. 
> 
> The older abort handler BusLogic_AbortCommand should be easy to change
> by just adjusting the locking. I do not have one of these adapter, but
> could look into the changes.

I think it's more than Buslogic, see my similar results with NEC. There
was a CD-RW and tape drive on the controller, I unplugged the tape drive,
didn't help. See attached dmsg and ksymoops.
 
> 
> andy barlak [andyb@island.net] wrote:
> > 
> > Buslogic is still not functional in 2.5.43.
> > Info below is from successive boots on the same system.
> > Two scsi HDs and one scsi cdrom.
> > Removing the cdrom changes nothing.
> > 
> > Kernel 2.4.19 has run buslogic scsi just fine:
> > 
> > SCSI subsystem driver Revision: 1.00
> > PCI: Assigned IRQ 10 for device 00:08.0
> > scsi: ***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
> > scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
> > scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
> > scsi0:   Firmware Version: 5.06J, I/O Address: 0xE800, IRQ Channel: 10/Level
> > scsi0:   PCI Bus: 0, Device: 8, Address: 0xED001000, Host Adapter SCSI ID: 7
> > scsi0:   Parity Checking: Disabled, Extended Translation: Disabled
> > scsi0:   Synchronous Negotiation: FFFFSFF#FFFFFFFF, Wide Negotiation: YYYYNYY#YY
> > YYYYYY
> > scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
> > scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
> > scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
> > scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
> > scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Disabled
> > scsi0:   SCSI Bus Termination: High Enabled, SCAM: Disabled
> > scsi0: *** BusLogic BT-958 Initialized Successfully ***
> > scsi0 : BusLogic BT-958
> >   Vendor: CONNER    Model: CFP2107E  2.14GB  Rev: 1423
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> >   Vendor: SEAGATE   Model: SX423451W         Rev: 9E18
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> >   Vendor: TOSHIBA   Model: CD-ROM XM-5701TA  Rev: 0167
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > scsi0: Target 0: Queue Depth 28, Wide Synchronous at 20.0 MB/sec, offset 15
> > scsi0: Target 1: Queue Depth 28, Wide Synchronous at 20.0 MB/sec, offset 15
> > scsi0: Target 2: Queue Depth 3, Synchronous at 10.0 MB/sec, offset 8
> > Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> > Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
> > SCSI device sda: 4194303 512-byte hdwr sectors (2147 MB)
> >  sda: sda1 sda2
> > SCSI device sdb: 45322644 512-byte hdwr sectors (23205 MB)
> >  sdb: sdb1 sdb2 sdb3
> > 
> > -----------------------------
> > 
> > 
> > 
> > Kernel 2.5.43 and earlier produce this dmesg info
> > (edited  redundant lines):
> > 
> > SCSI subsystem driver Revision: 1.00
> > PCI: Assigned IRQ 10 for device 00:08.0
> > scsi: ***** BusLogic SCSI Driver Version 2.1.16 of 18 July 2002 *****
> > scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
> > scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
> > scsi0:   Firmware Version: 5.06J, I/O Address: 0xE800, IRQ Channel: 10/Level
> > scsi0:   PCI Bus: 0, Device: 8, Address: 0xED001000, Host Adapter SCSI ID: 7
> > scsi0:   Parity Checking: Disabled, Extended Translation: Disabled
> > scsi0:   Synchronous Negotiation: FFFFSFF#FFFFFFFF, Wide Negotiation: YYYYNYY#YY
> > YYYYYY
> > scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
> > scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
> > scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
> > scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
> > scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Disabled
> > scsi0:   SCSI Bus Termination: High Enabled, SCAM: Disabled
> > scsi0: *** BusLogic BT-958 Initialized Successfully ***
> > scsi0 : BusLogic BT-958
> >   Vendor: CONNER    Model: CFP2107E  2.14GB  Rev: 1423
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> >   Vendor: SEAGATE   Model: SX423451W         Rev: 9E18
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 1 lun 0
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 1 lun 0
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 2 lun 0
> >   Vendor:           Model:                   Rev:
> >   Type:   Direct-Access                      ANSI SCSI revision: 00
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 2 lun 0
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 2 lun 0
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 3 lun 0
> >   Vendor:           Model:                   Rev:
> >   Type:   Direct-Access                      ANSI SCSI revision: 00
> > .
> > .
> > .
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 15 lun 0
> >   Vendor:           Model:                   Rev:
> >   Type:   Direct-Access                      ANSI SCSI revision: 00
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 15 lun 0
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 15 lun 0
> > st: Version 20021015, fixed bufsize 32768, wrt 30720, s/g segs 256
> > Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> > Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
> > Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
> > Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
> > Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
> > Attached scsi disk sdf at scsi0, channel 0, id 5, lun 0
> > Attached scsi disk sdg at scsi0, channel 0, id 6, lun 0
> > Attached scsi disk sdh at scsi0, channel 0, id 8, lun 0
> > Attached scsi disk sdi at scsi0, channel 0, id 9, lun 0
> > Attached scsi disk sdj at scsi0, channel 0, id 10, lun 0
> > Attached scsi disk sdk at scsi0, channel 0, id 11, lun 0
> > Attached scsi disk sdl at scsi0, channel 0, id 12, lun 0
> > Attached scsi disk sdm at scsi0, channel 0, id 13, lun 0
> > Attached scsi disk sdn at scsi0, channel 0, id 14, lun 0
> > Attached scsi disk sdo at scsi0, channel 0, id 15, lun 0
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 0 lun 0
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 0 lun 0
> > SCSI device sda: drive cache: write through
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 0 lun 0
> > sda : sector size 0 reported, assuming 512.
> > SCSI device sda: 1 512-byte hdwr sectors (0 MB)
> > .
> > .
> > .
> > 
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 15 lun 0
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 15 lun 0
> > SCSI device sdo: drive cache: write through
> > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> >  error recovery: host 0 channel 0 id 15 lun 0
> > sdo : sector size 0 reported, assuming 512.
> > SCSI device sdo: 1 512-byte hdwr sectors (0 MB)
> > Initializing USB Mass Storage driver...
> > 
> 
> -andmike
> --
> Michael Anderson
> andmike@us.ibm.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--1170656797-689491880-1035054756=:29078
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dmesg-2.5.43-mm2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1021019151236.29078B@gatekeeper.tmr.com>
Content-Description: full dmesg

TGludXggdmVyc2lvbiAyLjUuNDMgKHJvb3RAYmlsYm8udG1yLmNvbSkgKGdj
YyB2ZXJzaW9uIDIuOTYgMjAwMDA3MzEgKFJlZCBIYXQgTGludXggNy4zIDIu
OTYtMTEyKSkgIzEgU01QIEZyaSBPY3QgMTggMTc6MjI6MzkgRURUIDIwMDIN
ClZpZGVvIG1vZGUgdG8gYmUgdXNlZCBmb3IgcmVzdG9yZSBpcyBmZmZmDQpC
SU9TLXByb3ZpZGVkIHBoeXNpY2FsIFJBTSBtYXA6DQogQklPUy1lODIwOiAw
MDAwMDAwMDAwMDAwMDAwIC0gMDAwMDAwMDAwMDA5ZmMwMCAodXNhYmxlKQ0K
IEJJT1MtZTgyMDogMDAwMDAwMDAwMDA5ZmMwMCAtIDAwMDAwMDAwMDAwYTAw
MDAgKHJlc2VydmVkKQ0KIEJJT1MtZTgyMDogMDAwMDAwMDAwMDBmMDAwMCAt
IDAwMDAwMDAwMDAxMDAwMDAgKHJlc2VydmVkKQ0KIEJJT1MtZTgyMDogMDAw
MDAwMDAwMDEwMDAwMCAtIDAwMDAwMDAwMTAwMDAwMDAgKHVzYWJsZSkNCiBC
SU9TLWU4MjA6IDAwMDAwMDAwZmVjMDAwMDAgLSAwMDAwMDAwMGZlYzAxMDAw
IChyZXNlcnZlZCkNCiBCSU9TLWU4MjA6IDAwMDAwMDAwZmVlMDAwMDAgLSAw
MDAwMDAwMGZlZTAxMDAwIChyZXNlcnZlZCkNCiBCSU9TLWU4MjA6IDAwMDAw
MDAwZmZmZjAwMDAgLSAwMDAwMDAwMTAwMDAwMDAwIChyZXNlcnZlZCkNCjI1
Nk1CIExPV01FTSBhdmFpbGFibGUuDQpmb3VuZCBTTVAgTVAtdGFibGUgYXQg
MDAwZjViMzANCmhtLCBwYWdlIDAwMGY1MDAwIHJlc2VydmVkIHR3aWNlLg0K
aG0sIHBhZ2UgMDAwZjYwMDAgcmVzZXJ2ZWQgdHdpY2UuDQpobSwgcGFnZSAw
MDBmMTAwMCByZXNlcnZlZCB0d2ljZS4NCmhtLCBwYWdlIDAwMGYyMDAwIHJl
c2VydmVkIHR3aWNlLg0KT24gbm9kZSAwIHRvdGFscGFnZXM6IDY1NTM2DQog
IERNQSB6b25lOiA0MDk2IHBhZ2VzLCBMSUZPIGJhdGNoOjENCiAgTm9ybWFs
IHpvbmU6IDYxNDQwIHBhZ2VzLCBMSUZPIGJhdGNoOjE1DQogIEhpZ2hNZW0g
em9uZTogMCBwYWdlcywgTElGTyBiYXRjaDoxDQpJbnRlbCBNdWx0aVByb2Nl
c3NvciBTcGVjaWZpY2F0aW9uIHYxLjENCiAgICBWaXJ0dWFsIFdpcmUgY29t
cGF0aWJpbGl0eSBtb2RlLg0KT0VNIElEOiBPRU0wMDAwMCBQcm9kdWN0IElE
OiBQUk9EMDAwMDAwMDAgQVBJQyBhdDogMHhGRUUwMDAwMA0KUHJvY2Vzc29y
ICMwIDY6NiBBUElDIHZlcnNpb24gMTcNClByb2Nlc3NvciAjMSA2OjYgQVBJ
QyB2ZXJzaW9uIDE3DQpJL08gQVBJQyAjMiBWZXJzaW9uIDE3IGF0IDB4RkVD
MDAwMDAuDQpFbmFibGluZyBBUElDIG1vZGU6ICBGbGF0LiAgVXNpbmcgMSBJ
L08gQVBJQ3MNClByb2Nlc3NvcnM6IDINCkJ1aWxkaW5nIHpvbmVsaXN0IGZv
ciBub2RlIDogMA0KS2VybmVsIGNvbW1hbmQgbGluZTogYXV0byBCT09UX0lN
QUdFPTItNS00MyBybyByb290PTMwNSBCT09UX0ZJTEU9L2Jvb3Qvdm1saW51
ei0yLjUuNDMgaGRjPWlkZS1zY3NpDQppZGVfc2V0dXA6IGhkYz1pZGUtc2Nz
aQ0KSW5pdGlhbGl6aW5nIENQVSMwDQpEZXRlY3RlZCA0OTguMDY4IE1IeiBw
cm9jZXNzb3IuDQpDb25zb2xlOiBjb2xvdXIgVkdBKyA4MHgyNQ0KQ2FsaWJy
YXRpbmcgZGVsYXkgbG9vcC4uLiA5ODUuMDggQm9nb01JUFMNCk1lbW9yeTog
MjU1MTA0ay8yNjIxNDRrIGF2YWlsYWJsZSAoMTgzMmsga2VybmVsIGNvZGUs
IDYyNzZrIHJlc2VydmVkLCAxMjk0ayBkYXRhLCAxMzJrIGluaXQsIDBrIGhp
Z2htZW0pDQpTZWN1cml0eSBTY2FmZm9sZCB2MS4wLjAgaW5pdGlhbGl6ZWQN
CkRlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChvcmRl
cjogNiwgMjYyMTQ0IGJ5dGVzKQ0KSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiAxNjM4NCAob3JkZXI6IDUsIDEzMTA3MiBieXRlcykNCk1vdW50
LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTEyIChvcmRlcjogMCwgNDA5
NiBieXRlcykNCkNQVTogQmVmb3JlIHZlbmRvciBpbml0LCBjYXBzOiAwMTgz
ZmJmZiAwMDAwMDAwMCAwMDAwMDAwMCwgdmVuZG9yID0gMA0KQ1BVOiBMMSBJ
IGNhY2hlOiAxNkssIEwxIEQgY2FjaGU6IDE2Sw0KQ1BVOiBMMiBjYWNoZTog
MTI4Sw0KQ1BVOiBBZnRlciB2ZW5kb3IgaW5pdCwgY2FwczogMDE4M2ZiZmYg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCkludGVsIG1hY2hpbmUgY2hl
Y2sgYXJjaGl0ZWN0dXJlIHN1cHBvcnRlZC4NCkludGVsIG1hY2hpbmUgY2hl
Y2sgcmVwb3J0aW5nIGVuYWJsZWQgb24gQ1BVIzAuDQpDUFU6ICAgICBBZnRl
ciBnZW5lcmljLCBjYXBzOiAwMTgzZmJmZiAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMA0KQ1BVOiAgICAgICAgICAgICBDb21tb24gY2FwczogMDE4M2Zi
ZmYgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCkVuYWJsaW5nIGZhc3Qg
RlBVIHNhdmUgYW5kIHJlc3RvcmUuLi4gZG9uZS4NCkNoZWNraW5nICdobHQn
IGluc3RydWN0aW9uLi4uIE9LLg0KUE9TSVggY29uZm9ybWFuY2UgdGVzdGlu
ZyBieSBVTklGSVgNCkNQVTogQmVmb3JlIHZlbmRvciBpbml0LCBjYXBzOiAw
MTgzZmJmZiAwMDAwMDAwMCAwMDAwMDAwMCwgdmVuZG9yID0gMA0KQ1BVOiBM
MSBJIGNhY2hlOiAxNkssIEwxIEQgY2FjaGU6IDE2Sw0KQ1BVOiBMMiBjYWNo
ZTogMTI4Sw0KQ1BVOiBBZnRlciB2ZW5kb3IgaW5pdCwgY2FwczogMDE4M2Zi
ZmYgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCkludGVsIG1hY2hpbmUg
Y2hlY2sgcmVwb3J0aW5nIGVuYWJsZWQgb24gQ1BVIzAuDQpDUFU6ICAgICBB
ZnRlciBnZW5lcmljLCBjYXBzOiAwMTgzZmJmZiAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMA0KQ1BVOiAgICAgICAgICAgICBDb21tb24gY2FwczogMDE4
M2ZiZmYgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCkNQVTA6IEludGVs
IENlbGVyb24gKE1lbmRvY2lubykgc3RlcHBpbmcgMDUNCnBlci1DUFUgdGlt
ZXNsaWNlIGN1dG9mZjogMzY1LjQ2IHVzZWNzLg0KdGFzayBtaWdyYXRpb24g
Y2FjaGUgZGVjYXkgdGltZW91dDogMSBtc2Vjcy4NCmVuYWJsZWQgRXh0SU5U
IG9uIENQVSMwDQpFU1IgdmFsdWUgYmVmb3JlIGVuYWJsaW5nIHZlY3Rvcjog
MDAwMDAwMDANCkVTUiB2YWx1ZSBhZnRlciBlbmFibGluZyB2ZWN0b3I6IDAw
MDAwMDAwDQpCb290aW5nIHByb2Nlc3NvciAxLzEgZWlwIDIwMDANCkluaXRp
YWxpemluZyBDUFUjMQ0KbWFza2VkIEV4dElOVCBvbiBDUFUjMQ0KRVNSIHZh
bHVlIGJlZm9yZSBlbmFibGluZyB2ZWN0b3I6IDAwMDAwMDAwDQpFU1IgdmFs
dWUgYWZ0ZXIgZW5hYmxpbmcgdmVjdG9yOiAwMDAwMDAwMA0KQ2FsaWJyYXRp
bmcgZGVsYXkgbG9vcC4uLiA5OTMuMjggQm9nb01JUFMNCkNQVTogQmVmb3Jl
IHZlbmRvciBpbml0LCBjYXBzOiAwMTgzZmJmZiAwMDAwMDAwMCAwMDAwMDAw
MCwgdmVuZG9yID0gMA0KQ1BVOiBMMSBJIGNhY2hlOiAxNkssIEwxIEQgY2Fj
aGU6IDE2Sw0KQ1BVOiBMMiBjYWNoZTogMTI4Sw0KQ1BVOiBBZnRlciB2ZW5k
b3IgaW5pdCwgY2FwczogMDE4M2ZiZmYgMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDANCkludGVsIG1hY2hpbmUgY2hlY2sgcmVwb3J0aW5nIGVuYWJsZWQg
b24gQ1BVIzEuDQpDUFU6ICAgICBBZnRlciBnZW5lcmljLCBjYXBzOiAwMTgz
ZmJmZiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KQ1BVOiAgICAgICAg
ICAgICBDb21tb24gY2FwczogMDE4M2ZiZmYgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDANCkNQVTE6IEludGVsIENlbGVyb24gKE1lbmRvY2lubykgc3Rl
cHBpbmcgMDUNClRvdGFsIG9mIDIgcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDE5
NzguMzYgQm9nb01JUFMpLg0KRU5BQkxJTkcgSU8tQVBJQyBJUlFzDQpTZXR0
aW5nIDIgaW4gdGhlIHBoeXNfaWRfcHJlc2VudF9tYXANCi4uLmNoYW5naW5n
IElPLUFQSUMgcGh5c2ljYWwgQVBJQyBJRCB0byAyIC4uLiBvay4NCmluaXQg
SU9fQVBJQyBJUlFzDQogSU8tQVBJQyAoYXBpY2lkLXBpbikgMi0wLCAyLTks
IDItMTAsIDItMTEsIDItMTcsIDItMjAsIDItMjEsIDItMjIsIDItMjMgbm90
IGNvbm5lY3RlZC4NCi4uVElNRVI6IHZlY3Rvcj0weDMxIHBpbjE9MiBwaW4y
PTANCm51bWJlciBvZiBNUCBJUlEgc291cmNlczogMTYuDQpudW1iZXIgb2Yg
SU8tQVBJQyAjMiByZWdpc3RlcnM6IDI0Lg0KdGVzdGluZyB0aGUgSU8gQVBJ
Qy4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQoNCklPIEFQSUMgIzIuLi4uLi4N
Ci4uLi4gcmVnaXN0ZXIgIzAwOiAwMjAwMDAwMA0KLi4uLi4uLiAgICA6IHBo
eXNpY2FsIEFQSUMgaWQ6IDAyDQouLi4uIHJlZ2lzdGVyICMwMTogMDAxNzAw
MTENCi4uLi4uLi4gICAgIDogbWF4IHJlZGlyZWN0aW9uIGVudHJpZXM6IDAw
MTcNCi4uLi4uLi4gICAgIDogUFJRIGltcGxlbWVudGVkOiAwDQouLi4uLi4u
ICAgICA6IElPIEFQSUMgdmVyc2lvbjogMDAxMQ0KLi4uLiByZWdpc3RlciAj
MDI6IDAwMDAwMDAwDQouLi4uLi4uICAgICA6IGFyYml0cmF0aW9uOiAwMA0K
Li4uLiBJUlEgcmVkaXJlY3Rpb24gdGFibGU6DQogTlIgTG9nIFBoeSBNYXNr
IFRyaWcgSVJSIFBvbCBTdGF0IERlc3QgRGVsaSBWZWN0OiAgIA0KIDAwIDAw
MCAwMCAgMSAgICAwICAgIDAgICAwICAgMCAgICAwICAgIDAgICAgMDANCiAw
MSAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDM5
DQogMDIgMDAxIDAxICAwICAgIDAgICAgMCAgIDAgICAwICAgIDEgICAgMSAg
ICAzMQ0KIDAzIDAwMSAwMSAgMCAgICAwICAgIDAgICAwICAgMCAgICAxICAg
IDEgICAgNDENCiAwNCAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAg
MSAgICAxICAgIDQ5DQogMDUgMDAxIDAxICAwICAgIDAgICAgMCAgIDAgICAw
ICAgIDEgICAgMSAgICA1MQ0KIDA2IDAwMSAwMSAgMCAgICAwICAgIDAgICAw
ICAgMCAgICAxICAgIDEgICAgNTkNCiAwNyAwMDEgMDEgIDAgICAgMCAgICAw
ICAgMCAgIDAgICAgMSAgICAxICAgIDYxDQogMDggMDAxIDAxICAwICAgIDAg
ICAgMCAgIDAgICAwICAgIDEgICAgMSAgICA2OQ0KIDA5IDAwMCAwMCAgMSAg
ICAwICAgIDAgICAwICAgMCAgICAwICAgIDAgICAgMDANCiAwYSAwMDAgMDAg
IDEgICAgMCAgICAwICAgMCAgIDAgICAgMCAgICAwICAgIDAwDQogMGIgMDAw
IDAwICAxICAgIDAgICAgMCAgIDAgICAwICAgIDAgICAgMCAgICAwMA0KIDBj
IDAwMSAwMSAgMCAgICAwICAgIDAgICAwICAgMCAgICAxICAgIDEgICAgNzEN
CiAwZCAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAg
IDc5DQogMGUgMDAxIDAxICAwICAgIDAgICAgMCAgIDAgICAwICAgIDEgICAg
MSAgICA4MQ0KIDBmIDAwMSAwMSAgMCAgICAwICAgIDAgICAwICAgMCAgICAx
ICAgIDEgICAgODkNCiAxMCAwMDEgMDEgIDEgICAgMSAgICAwICAgMSAgIDAg
ICAgMSAgICAxICAgIDkxDQogMTEgMDAwIDAwICAxICAgIDAgICAgMCAgIDAg
ICAwICAgIDAgICAgMCAgICAwMA0KIDEyIDAwMSAwMSAgMSAgICAxICAgIDAg
ICAxICAgMCAgICAxICAgIDEgICAgOTkNCiAxMyAwMDEgMDEgIDEgICAgMSAg
ICAwICAgMSAgIDAgICAgMSAgICAxICAgIEExDQogMTQgMDAwIDAwICAxICAg
IDAgICAgMCAgIDAgICAwICAgIDAgICAgMCAgICAwMA0KIDE1IDAwMCAwMCAg
MSAgICAwICAgIDAgICAwICAgMCAgICAwICAgIDAgICAgMDANCiAxNiAwMDAg
MDAgIDEgICAgMCAgICAwICAgMCAgIDAgICAgMCAgICAwICAgIDAwDQogMTcg
MDAwIDAwICAxICAgIDAgICAgMCAgIDAgICAwICAgIDAgICAgMCAgICAwMA0K
SVJRIHRvIHBpbiBtYXBwaW5nczoNCklSUTAgLT4gMDoyDQpJUlExIC0+IDA6
MQ0KSVJRMyAtPiAwOjMNCklSUTQgLT4gMDo0DQpJUlE1IC0+IDA6NQ0KSVJR
NiAtPiAwOjYNCklSUTcgLT4gMDo3DQpJUlE4IC0+IDA6OA0KSVJROSAtPiAw
OjE5DQpJUlExMCAtPiAwOjE2DQpJUlExMSAtPiAwOjE4DQpJUlExMiAtPiAw
OjEyDQpJUlExMyAtPiAwOjEzDQpJUlExNCAtPiAwOjE0DQpJUlExNSAtPiAw
OjE1DQouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4gZG9u
ZS4NClVzaW5nIGxvY2FsIEFQSUMgdGltZXIgaW50ZXJydXB0cy4NCmNhbGli
cmF0aW5nIEFQSUMgdGltZXIgLi4uDQouLi4uLiBDUFUgY2xvY2sgc3BlZWQg
aXMgNDk3LjA5NTMgTUh6Lg0KLi4uLi4gaG9zdCBidXMgY2xvY2sgc3BlZWQg
aXMgODIuMDk5MiBNSHouDQpjaGVja2luZyBUU0Mgc3luY2hyb25pemF0aW9u
IGFjcm9zcyAyIENQVXM6IHBhc3NlZC4NClN0YXJ0aW5nIG1pZ3JhdGlvbiB0
aHJlYWQgZm9yIGNwdSAwDQpCcmluZ2luZyB1cCAxDQpDUFUgMSBJUyBOT1cg
VVAhDQpTdGFydGluZyBtaWdyYXRpb24gdGhyZWFkIGZvciBjcHUgMQ0KQ1BV
UyBkb25lIDQyOTQ5NjcyOTUNCkxpbnV4IE5FVDQuMCBmb3IgTGludXggMi40
DQpCYXNlZCB1cG9uIFN3YW5zZWEgVW5pdmVyc2l0eSBDb21wdXRlciBTb2Np
ZXR5IE5FVDMuMDM5DQpJbml0aWFsaXppbmcgUlQgbmV0bGluayBzb2NrZXQN
Cm10cnI6IHYyLjAgKDIwMDIwNTE5KQ0KUENJOiBQQ0kgQklPUyByZXZpc2lv
biAyLjEwIGVudHJ5IGF0IDB4ZmI0MjAsIGxhc3QgYnVzPTENClBDSTogVXNp
bmcgY29uZmlndXJhdGlvbiB0eXBlIDENCmFkZGluZyAnJyB0byBjcHUgY2xh
c3MgaW50ZXJmYWNlcw0KYWRkaW5nICcnIHRvIGNwdSBjbGFzcyBpbnRlcmZh
Y2VzDQpkcml2ZXJzL3VzYi9jb3JlL3VzYi5jOiByZWdpc3RlcmVkIG5ldyBk
cml2ZXIgaHViDQpQQ0k6IFByb2JpbmcgUENJIGhhcmR3YXJlDQpQQ0k6IFBy
b2JpbmcgUENJIGhhcmR3YXJlIChidXMgMDApDQpQQ0k6IFVzaW5nIElSUSBy
b3V0ZXIgUElJWCBbODA4Ni83MTEwXSBhdCAwMDowNy4wDQpzbGFiOiByZWFw
IHRpbWVyIHN0YXJ0ZWQgZm9yIGNwdSAwDQpzbGFiOiByZWFwIHRpbWVyIHN0
YXJ0ZWQgZm9yIGNwdSAxDQpTdGFydGluZyBrc3dhcGQNCkJJTzogcG9vbCBv
ZiAyNTYgc2V0dXAsIDE0S2IgKDU2IGJ5dGVzL2JpbykNCmJpb3ZlYyBwb29s
WzBdOiAgIDEgYnZlY3M6IDI1NiBlbnRyaWVzICgxMiBieXRlcykNCmJpb3Zl
YyBwb29sWzFdOiAgIDQgYnZlY3M6IDI1NiBlbnRyaWVzICg0OCBieXRlcykN
CmJpb3ZlYyBwb29sWzJdOiAgMTYgYnZlY3M6IDI1NiBlbnRyaWVzICgxOTIg
Ynl0ZXMpDQpiaW92ZWMgcG9vbFszXTogIDY0IGJ2ZWNzOiAyNTYgZW50cmll
cyAoNzY4IGJ5dGVzKQ0KYmlvdmVjIHBvb2xbNF06IDEyOCBidmVjczogMjU2
IGVudHJpZXMgKDE1MzYgYnl0ZXMpDQpiaW92ZWMgcG9vbFs1XTogMjU2IGJ2
ZWNzOiAyNTYgZW50cmllcyAoMzA3MiBieXRlcykNCmFpb19zZXR1cDogc2l6
ZW9mKHN0cnVjdCBwYWdlKSA9IDQwDQpKb3VybmFsbGVkIEJsb2NrIERldmlj
ZSBkcml2ZXIgbG9hZGVkDQpJbnN0YWxsaW5nIGtuZnNkIChjb3B5cmlnaHQg
KEMpIDE5OTYgb2tpckBtb25hZC5zd2IuZGUpLg0KQ2FwYWJpbGl0eSBMU00g
aW5pdGlhbGl6ZWQNCkxpbWl0aW5nIGRpcmVjdCBQQ0kvUENJIHRyYW5zZmVy
cy4NClNlcmlhbDogODI1MC8xNjU1MCBkcml2ZXIgJFJldmlzaW9uOiAxLjkw
ICQgSVJRIHNoYXJpbmcgZW5hYmxlZA0KdHR5UzAgYXQgSS9PIDB4M2Y4IChp
cnEgPSA0KSBpcyBhIDE2NTUwQQ0KdHR5UzEgYXQgSS9PIDB4MmY4IChpcnEg
PSAzKSBpcyBhIDE2NTUwQQ0KcHR5OiAyNTYgVW5peDk4IHB0eXMgY29uZmln
dXJlZA0KR2VuZXJpYyBSVEMgRHJpdmVyIHYxLjA2DQpMaW51eCBhZ3BnYXJ0
IGludGVyZmFjZSB2MC45OSAoYykgSmVmZiBIYXJ0bWFubg0KYWdwZ2FydDog
TWF4aW11bSBtYWluIG1lbW9yeSB0byB1c2UgZm9yIGFncCBtZW1vcnk6IDIw
NE0NCmFncGdhcnQ6IERldGVjdGVkIEludGVsIDQ0MEJYIGNoaXBzZXQNCmFn
cGdhcnQ6IEFHUCBhcGVydHVyZSBpcyA2NE0gQCAweGUwMDAwMDAwDQpibG9j
ayByZXF1ZXN0IHF1ZXVlczoNCiAxMjggcmVxdWVzdHMgcGVyIHJlYWQgcXVl
dWUNCiAxMjggcmVxdWVzdHMgcGVyIHdyaXRlIHF1ZXVlDQogOCByZXF1ZXN0
cyBwZXIgYmF0Y2gNCiBlbnRlciBjb25nZXN0aW9uIGF0IDMxDQogZXhpdCBj
b25nZXN0aW9uIGF0IDMzDQpGbG9wcHkgZHJpdmUocyk6IGZkMCBpcyAxLjQ0
TQ0KRkRDIDAgaXMgYSBwb3N0LTE5OTEgODIwNzcNCmxvb3A6IGxvYWRlZCAo
bWF4IDggZGV2aWNlcykNClVuaWZvcm0gTXVsdGktUGxhdGZvcm0gRS1JREUg
ZHJpdmVyIFJldmlzaW9uOiA3LjAwYWxwaGEyDQppZGU6IEFzc3VtaW5nIDMz
TUh6IHN5c3RlbSBidXMgc3BlZWQgZm9yIFBJTyBtb2Rlczsgb3ZlcnJpZGUg
d2l0aCBpZGVidXM9eHgNClBJSVg0OiBJREUgY29udHJvbGxlciBhdCBQQ0kg
c2xvdCAwMDowNy4xDQpQSUlYNDogY2hpcHNldCByZXZpc2lvbiAxDQpQSUlY
NDogbm90IDEwMCUgbmF0aXZlIG1vZGU6IHdpbGwgcHJvYmUgaXJxcyBsYXRl
cg0KICAgIGlkZTA6IEJNLURNQSBhdCAweGYwMDAtMHhmMDA3LCBCSU9TIHNl
dHRpbmdzOiBoZGE6RE1BLCBoZGI6cGlvDQogICAgaWRlMTogQk0tRE1BIGF0
IDB4ZjAwOC0weGYwMGYsIEJJT1Mgc2V0dGluZ3M6IGhkYzpETUEsIGhkZDpw
aW8NCmhkYTogV0RDIEFDMjY0MDBSLCBBVEEgRElTSyBkcml2ZQ0KaWRlMCBh
dCAweDFmMC0weDFmNywweDNmNiBvbiBpcnEgMTQNCmhkYzogU09OWSBDRC1S
VyBDUlgxNDBFLCBBVEFQSSBDRC9EVkQtUk9NIGRyaXZlDQpoZGQ6IElPTUVH
QSBaSVAgMTAwIEFUQVBJLCBBVEFQSSBGTE9QUFkgZHJpdmUNCmlkZTEgYXQg
MHgxNzAtMHgxNzcsMHgzNzYgb24gaXJxIDE1DQpIUFQzNjY6IG9uYm9hcmQg
dmVyc2lvbiBvZiBjaGlwc2V0LCBwaW4xPTEgcGluMj0yDQpIUFQzNjY6IElE
RSBjb250cm9sbGVyIGF0IFBDSSBzbG90IDAwOjEzLjANClBDSTogRW5hYmxp
bmcgZGV2aWNlIDAwOjEzLjAgKDAwMDUgLT4gMDAwNykNCkhQVDM2NjogY2hp
cHNldCByZXZpc2lvbiAxDQpIUFQzNjY6IG5vdCAxMDAlIG5hdGl2ZSBtb2Rl
OiB3aWxsIHByb2JlIGlycXMgbGF0ZXINCiAgICBpZGUyOiBCTS1ETUEgYXQg
MHhlMDAwLTB4ZTAwNywgQklPUyBzZXR0aW5nczogaGRlOkRNQSwgaGRmOnBp
bw0KICAgIGlkZTM6IEJNLURNQSBhdCAweGVjMDAtMHhlYzA3LCBCSU9TIHNl
dHRpbmdzOiBoZGc6cGlvLCBoZGg6cGlvDQpoZGU6IFdEQyBXRDIwNUJBLCBB
VEEgRElTSyBkcml2ZQ0KaWRlMiBhdCAweGQ4MDAtMHhkODA3LDB4ZGMwMiBv
biBpcnEgMTENCmhkYTogdGFza19ub19kYXRhX2ludHI6IHN0YXR1cz0weDUx
IHsgRHJpdmVSZWFkeSBTZWVrQ29tcGxldGUgRXJyb3IgfQ0KaGRhOiB0YXNr
X25vX2RhdGFfaW50cjogZXJyb3I9MHgwNCB7IERyaXZlU3RhdHVzRXJyb3Ig
fQ0KaGRhOiBob3N0IHByb3RlY3RlZCBhcmVhID0+IDENCmhkYTogMTI1OTQ5
NjAgc2VjdG9ycyAoNjQ0OSBNQikgdy81MTJLaUIgQ2FjaGUsIENIUz03ODQv
MjU1LzYzLCBVRE1BKDMzKQ0KIGhkYTogaGRhMSBoZGEyIGhkYTMgaGRhNCA8
IGhkYTUgPg0KaGRlOiBob3N0IHByb3RlY3RlZCBhcmVhID0+IDENCmhkZTog
NDAwODgxNjAgc2VjdG9ycyAoMjA1MjUgTUIpIHcvMjA0OEtpQiBDYWNoZSwg
Q0hTPTM5NzcwLzE2LzYzLCBVRE1BKDY2KQ0KIGhkZTogaGRlMQ0KU0NTSSBz
dWJzeXN0ZW0gZHJpdmVyIFJldmlzaW9uOiAxLjAwDQpzeW01M2M4eHg6IGF0
IFBDSSBidXMgMCwgZGV2aWNlIDksIGZ1bmN0aW9uIDANCnN5bTUzYzh4eDog
bm90IGluaXRpYWxpemluZywgZGV2aWNlIG5vdCBzdXBwb3J0ZWQNCnJlcXVl
c3RfbW9kdWxlW3Njc2lfaG9zdGFkYXB0ZXJdOiBub3QgcmVhZHkNCkxpbnV4
IEtlcm5lbCBDYXJkIFNlcnZpY2VzIDMuMS4yMg0KICBvcHRpb25zOiAgW3Bj
aV0gW2NhcmRidXNdDQpJbnRlbCBQQ0lDIHByb2JlOiANCiAgVmFkZW0gVkct
NDY4IElTQS10by1QQ01DSUEgYXQgcG9ydCAweDNlMCBvZnMgMHgwMCwgMiBz
b2NrZXRzDQogICAgaG9zdCBvcHRzIFswXTogbm9uZQ0KICAgIGhvc3Qgb3B0
cyBbMV06IG5vbmUNCiAgICBJU0EgaXJxcyAoc2Nhbm5lZCkgPSAzLDQsNSw3
IHBvbGxpbmcgaW50ZXJ2YWwgPSAxMDAwIG1zDQpEYXRhYm9vayBUQ0lDLTIg
UENNQ0lBIHByb2JlOiBub3QgZm91bmQuDQpkcml2ZXJzL3VzYi9ob3N0L3Vo
Y2ktaGNkLmM6IFVTQiBVbml2ZXJzYWwgSG9zdCBDb250cm9sbGVyIEludGVy
ZmFjZSBkcml2ZXIgdjIuMA0KZHJpdmVycy91c2IvY29yZS9oY2QtcGNpLmM6
IHVoY2ktaGNkIEAgMDA6MDcuMiwgSW50ZWwgQ29ycC4gODIzNzFBQi9FQi9N
QiBQSUlYNCBVU0INCmRyaXZlcnMvdXNiL2NvcmUvaGNkLXBjaS5jOiBpcnEg
OSwgaW8gYmFzZSAwMDAwZDAwMA0KZHJpdmVycy91c2IvY29yZS9oY2QuYzog
bmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAx
DQpkcml2ZXJzL3VzYi9jb3JlL2h1Yi5jOiBVU0IgaHViIGZvdW5kIGF0IDAN
CmRyaXZlcnMvdXNiL2NvcmUvaHViLmM6IDIgcG9ydHMgZGV0ZWN0ZWQNCklu
aXRpYWxpemluZyBVU0IgTWFzcyBTdG9yYWdlIGRyaXZlci4uLg0KZHJpdmVy
cy91c2IvY29yZS91c2IuYzogcmVnaXN0ZXJlZCBuZXcgZHJpdmVyIHVzYi1z
dG9yYWdlDQpVU0IgTWFzcyBTdG9yYWdlIHN1cHBvcnQgcmVnaXN0ZXJlZC4N
CnJlZ2lzdGVyIGludGVyZmFjZSAnbW91c2UnIHdpdGggY2xhc3MgJ2lucHV0
DQptaWNlOiBQUy8yIG1vdXNlIGRldmljZSBjb21tb24gZm9yIGFsbCBtaWNl
DQpsb2dpYm0uYzogRGlkbid0IGZpbmQgTG9naXRlY2ggYnVzbW91c2UgYXQg
MHgyM2MNCmlucHV0OiBQQyBTcGVha2VyDQppbnB1dDogUFMvMiBHZW5lcmlj
IE1vdXNlIG9uIGlzYTAwNjAvc2VyaW8xDQpzZXJpbzogaTgwNDIgQVVYIHBv
cnQgYXQgMHg2MCwweDY0IGlycSAxMg0KaW5wdXQ6IEFUIFNldCAyIGtleWJv
YXJkIG9uIGlzYTAwNjAvc2VyaW8wDQpzZXJpbzogaTgwNDIgS0JEIHBvcnQg
YXQgMHg2MCwweDY0IGlycSAxDQplczEzNzE6IHZlcnNpb24gdjAuMzAgdGlt
ZSAxNzoyMDoxNyBPY3QgMTggMjAwMg0KTkVUNDogTGludXggVENQL0lQIDEu
MCBmb3IgTkVUNC4wDQpJUDogcm91dGluZyBjYWNoZSBoYXNoIHRhYmxlIG9m
IDIwNDggYnVja2V0cywgMTZLYnl0ZXMNClRDUDogSGFzaCB0YWJsZXMgY29u
ZmlndXJlZCAoZXN0YWJsaXNoZWQgMTYzODQgYmluZCAxNjM4NCkNCk5FVDQ6
IFVuaXggZG9tYWluIHNvY2tldHMgMS4wL1NNUCBmb3IgTGludXggTkVUNC4w
Lg0Ka2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vj
b25kcw0KRVhUMy1mczogbW91bnRlZCBmaWxlc3lzdGVtIHdpdGggb3JkZXJl
ZCBkYXRhIG1vZGUuDQpWRlM6IE1vdW50ZWQgcm9vdCAoZXh0MyBmaWxlc3lz
dGVtKSByZWFkb25seS4NCkZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6
IDEzMmsgZnJlZWQNCkFkZGluZyA0MDk2NDhrIHN3YXAgb24gL2Rldi9oZGEy
LiAgUHJpb3JpdHk6LTEgZXh0ZW50czoxDQpFWFQzIEZTIDIuNC0wLjkuMTYs
IDAyIERlYyAyMDAxIG9uIGlkZTAoMyw1KSwgaW50ZXJuYWwgam91cm5hbA0K
a2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vjb25k
cw0KRVhUMyBGUyAyLjQtMC45LjE2LCAwMiBEZWMgMjAwMSBvbiBpZGUwKDMs
MSksIGludGVybmFsIGpvdXJuYWwNCkVYVDMtZnM6IG1vdW50ZWQgZmlsZXN5
c3RlbSB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLg0Ka2pvdXJuYWxkIHN0YXJ0
aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vjb25kcw0KRVhUMyBGUyAyLjQt
MC45LjE2LCAwMiBEZWMgMjAwMSBvbiBpZGUwKDMsMyksIGludGVybmFsIGpv
dXJuYWwNCkVYVDMtZnM6IG1vdW50ZWQgZmlsZXN5c3RlbSB3aXRoIG9yZGVy
ZWQgZGF0YSBtb2RlLg0Kc2NzaTAgOiBTQ1NJIGhvc3QgYWRhcHRlciBlbXVs
YXRpb24gZm9yIElERSBBVEFQSSBkZXZpY2VzDQogIFZlbmRvcjogU09OWSAg
ICAgIE1vZGVsOiBDRC1SVyAgQ1JYMTQwRSAgICBSZXY6IDEuMG4NCiAgVHlw
ZTogICBDRC1ST00gICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFOU0kg
U0NTSSByZXZpc2lvbjogMDINCiAgVmVuZG9yOiBJT01FR0EgICAgTW9kZWw6
IFpJUCAxMDAgICAgICAgICAgIFJldjogMTQuQQ0KICBUeXBlOiAgIERpcmVj
dC1BY2Nlc3MgICAgICAgICAgICAgICAgICAgICAgQU5TSSBTQ1NJIHJldmlz
aW9uOiAwMA0KQXR0YWNoZWQgc2NzaSByZW1vdmFibGUgZGlzayBzZGEgYXQg
c2NzaTAsIGNoYW5uZWwgMCwgaWQgMSwgbHVuIDANClNDU0kgZGV2aWNlIHNk
YTogZHJpdmUgY2FjaGU6IHdyaXRlIGJhY2sNCm5jcjUzYzh4eDogYXQgUENJ
IGJ1cyAwLCBkZXZpY2UgOSwgZnVuY3Rpb24gMA0KbmNyNTNjOHh4OiA1M2M4
MjUgZGV0ZWN0ZWQgDQpuY3I1M2M4MjUtMDogcmV2IDB4MiBvbiBwY2kgYnVz
IDAgZGV2aWNlIDkgZnVuY3Rpb24gMCBpcnEgOQ0KbmNyNTNjODI1LTA6IElE
IDcsIEZhc3QtMTAsIFBhcml0eSBDaGVja2luZw0Kc2NzaTEgOiBuY3I1M2M4
eHgtMy40LjNiLTIwMDEwNTEyDQpuY3I1M2M4MjUtMC08MiwqPjogdGFyZ2V0
IGRpZCBub3QgcmVwb3J0IFNZTkMuDQogIFZlbmRvcjogUEhJTElQUyAgIE1v
ZGVsOiBDREQyNjAwICAgICAgICAgICBSZXY6IDEuMDcNCiAgVHlwZTogICBD
RC1ST00gICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFOU0kgU0NTSSBy
ZXZpc2lvbjogMDINClNDU0kgZGV2aWNlIHNkYTogZHJpdmUgY2FjaGU6IHdy
aXRlIGJhY2sNCnNkYSA6IFJFQUQgQ0FQQUNJVFkgZmFpbGVkLg0Kc2RhIDog
c3RhdHVzPTEsIG1lc3NhZ2U9MDAsIGhvc3Q9MCwgZHJpdmVyPTAwIA0Kc2Rh
IDogc2Vuc2Ugbm90IGF2YWlsYWJsZS4gDQpzZGE6IFdyaXRlIFByb3RlY3Qg
aXMgb2ZmDQpzZGE6IE1vZGUgU2Vuc2U6IDQ1IDAwIDAwIDA4DQotLS0tLS0t
LS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCmtlcm5lbCBCVUcgYXQg
ZHJpdmVycy9iYXNlL2NvcmUuYzoyNjkhDQppbnZhbGlkIG9wZXJhbmQ6IDAw
MDANCm5jcjUzYzh4eCBpZGUtc2NzaSAgDQpDUFU6ICAgIDANCkVJUDogICAg
MDA2MDpbPGMwMWUyZDkwPl0gICAgTm90IHRhaW50ZWQNCkVGTEFHUzogMDAw
MTAyMDINCkVJUCBpcyBhdCBwdXRfZGV2aWNlKzB4NTAvMHg4MA0KZWF4OiAw
MDAwMDAwMSAgIGVieDogY2Y1M2I5NjQgICBlY3g6IGMwM2VlNWQwICAgZWR4
OiBjZjUzYjlmYw0KZXNpOiBjZjk0OGM5OCAgIGVkaTogY2Y5NDhjMDAgICBl
YnA6IGQwOGJmMmUwICAgZXNwOiBjZjYwZmYxNA0KZHM6IDAwNjggICBlczog
MDA2OCAgIHNzOiAwMDY4DQpQcm9jZXNzIG1vZHByb2JlIChwaWQ6IDMzMiwg
dGhyZWFkaW5mbz1jZjYwZTAwMCB0YXNrPWNmN2M3OTgwKQ0KU3RhY2s6IDAw
MDAwMDAwIGNmNTNiODAwIGMwMjJiOGM5IGNmNTNiOTY0IGZmZmZmZmY0IGNm
ZGU2MDAwIDAwMDAwMjg2IGMwMTRmZWJlIA0KICAgICAgIGNmZGU2MDA5IDAw
MDAwMDA4IGZmODgzZTYwIGZmZmZmZmZlIGMwM2JkYTAwIDAwMDAwMDAwIGMw
MTM4YjRmIGMwMTM4YjY2IA0KICAgICAgIGMxMjU2MmEwIGMxMjU2MmEwIDAw
MDAwMWZmIDAwMDAwMDAwIGMwM2JlNDAwIDAwMDAwMDAwIGMwMTM4ZWEyIGMw
M2JkYTAwIA0KQ2FsbCBUcmFjZToNCiBbPGMwMjJiOGM5Pl0gc2NzaV91bnJl
Z2lzdGVyX2hvc3QrMHgyNTkvMHg1NDANCiBbPGMwMTRmZWJlPl0gZ2V0bmFt
ZSsweDVlLzB4YTANCiBbPGMwMTM4YjRmPl0gYnVmZmVyZWRfcm1xdWV1ZSsw
eDEyZi8weDE1MA0KIFs8YzAxMzhiNjY+XSBidWZmZXJlZF9ybXF1ZXVlKzB4
MTQ2LzB4MTUwDQogWzxjMDEzOGVhMj5dIF9fYWxsb2NfcGFnZXMrMHhiMi8w
eDI5MA0KIFs8ZDA4Yjk4OGE+XSBleGl0X3RoaXNfc2NzaV9kcml2ZXIrMHhh
LzB4YyBbbmNyNTNjOHh4XQ0KIFs8ZDA4YmYyZTA+XSBkcml2ZXJfdGVtcGxh
dGUrMHgwLzB4ODAgW25jcjUzYzh4eF0NCiBbPGMwMTFjMDdlPl0gZnJlZV9t
b2R1bGUrMHgxZS8weGYwDQogWzxjMDExYjQ1ND5dIHN5c19kZWxldGVfbW9k
dWxlKzB4MTU0LzB4MmUwDQogWzxjMDEwNzM2Zj5dIHN5c2NhbGxfY2FsbCsw
eDcvMHhiDQoNCkNvZGU6IDBmIDBiIDBkIDAxIGEzIDkwIDJlIGMwIDhiIDgz
IGQwIDAwIDAwIDAwIDg1IGMwIDc0IDA0IDUzIGZmIA0KIDw2PnBhcnBvcnQw
OiBQQy1zdHlsZSBhdCAweDM3OCAoMHg3NzgpIFtQQ1NQUCxUUklTVEFURSxF
UFBdDQpwYXJwb3J0MDogaXJxIDcgZGV0ZWN0ZWQNCnBhcnBvcnQwOiBjcHBf
ZGFpc3k6IGFhNTUwMGZmKDM4KQ0KcGFycG9ydDA6IGFzc2lnbl9hZGRyczog
YWE1NTAwZmYoMzgpDQpwYXJwb3J0MDogY3BwX2RhaXN5OiBhYTU1MDBmZigz
OCkNCnBhcnBvcnQwOiBhc3NpZ25fYWRkcnM6IGFhNTUwMGZmKDM4KQ0KaXNh
cG5wOiBTY2FubmluZyBmb3IgUG5QIGNhcmRzLi4uDQppc2FwbnA6IENhcmQg
J05FMjAwMCBQTFVHICYgUExBWSBFVEhFUk5FVCBDQVJEJw0KaXNhcG5wOiAx
IFBsdWcgJiBQbGF5IGNhcmQgZGV0ZWN0ZWQgdG90YWwNCm5lLmM6djEuMTAg
OS8yMy85NCBEb25hbGQgQmVja2VyIChiZWNrZXJAc2N5bGQuY29tKQ0KTGFz
dCBtb2RpZmllZCBOb3YgMSwgMjAwMCBieSBQYXVsIEdvcnRtYWtlcg0KTkUq
MDAwIGV0aGVyY2FyZCBwcm9iZSBhdCAweDMwMDogMDAgMDAgZTggNDYgNmQg
YTENCmV0aDA6IE5FMjAwMCBmb3VuZCBhdCAweDMwMCwgdXNpbmcgSVJRIDMu
DQpldGgwOiBpbnRlcnJ1cHQgZnJvbSBzdG9wcGVkIGNhcmQNCm5lLmM6IElT
QVBuUCByZXBvcnRzIEdlbmVyaWMgUE5QIGF0IGkvbyAweDIyMCwgaXJxIDUu
DQpORSowMDAgZXRoZXJjYXJkIHByb2JlIGF0IDB4MjIwOiAwMCAwMCBlOCA0
NiA2ZCBhMQ0KZXRoMTogTkUyMDAwIGZvdW5kIGF0IDB4MjIwLCB1c2luZyBJ
UlEgNS4NCmNzOiBJTyBwb3J0IHByb2JlIDB4MGMwMC0weDBjZmY6IGNsZWFu
Lg0KY3M6IElPIHBvcnQgcHJvYmUgMHgwMTAwLTB4MDRmZjogZXhjbHVkaW5n
IDB4MjkwLTB4Mjk3IDB4Mzc4LTB4MzdmIDB4NGQwLTB4NGQ3DQpjczogSU8g
cG9ydCBwcm9iZSAweDBhMDAtMHgwYWZmOiBleGNsdWRpbmcgMHhhMjAtMHhh
MmYNCg==
--1170656797-689491880-1035054756=:29078
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kso-2.5.43-mm2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1021019151236.29078C@gatekeeper.tmr.com>
Content-Description: ksymoops output

a3N5bW9vcHMgMi40LjQgb24gaTY4NiAyLjUuNDMuICBPcHRpb25zIHVzZWQN
CiAgICAgLVYgKGRlZmF1bHQpDQogICAgIC1rIC9wcm9jL2tzeW1zIChkZWZh
dWx0KQ0KICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQ0KICAgICAt
byAvbGliL21vZHVsZXMvMi41LjQzLyAoZGVmYXVsdCkNCiAgICAgLW0gL2Jv
b3QvU3lzdGVtLm1hcC0yLjUuNDMgKGRlZmF1bHQpDQoNCldhcm5pbmc6IFlv
dSBkaWQgbm90IHRlbGwgbWUgd2hlcmUgdG8gZmluZCBzeW1ib2wgaW5mb3Jt
YXRpb24uICBJIHdpbGwNCmFzc3VtZSB0aGF0IHRoZSBsb2cgbWF0Y2hlcyB0
aGUga2VybmVsIGFuZCBtb2R1bGVzIHRoYXQgYXJlIHJ1bm5pbmcNCnJpZ2h0
IG5vdyBhbmQgSSdsbCB1c2UgdGhlIGRlZmF1bHQgb3B0aW9ucyBhYm92ZSBm
b3Igc3ltYm9sIHJlc29sdXRpb24uDQpJZiB0aGUgY3VycmVudCBrZXJuZWwg
YW5kL29yIG1vZHVsZXMgZG8gbm90IG1hdGNoIHRoZSBsb2csIHlvdSBjYW4g
Z2V0DQptb3JlIGFjY3VyYXRlIG91dHB1dCBieSB0ZWxsaW5nIG1lIHRoZSBr
ZXJuZWwgdmVyc2lvbiBhbmQgd2hlcmUgdG8gZmluZA0KbWFwLCBtb2R1bGVz
LCBrc3ltcyBldGMuICBrc3ltb29wcyAtaCBleHBsYWlucyB0aGUgb3B0aW9u
cy4NCg0KV2FybmluZyAoY29tcGFyZV9rc3ltc19sc21vZCk6IG1vZHVsZSBu
Y3I1M2M4eHggaXMgaW4gbHNtb2QgYnV0IG5vdCBpbiBrc3ltcywgcHJvYmFi
bHkgbm8gc3ltYm9scyBleHBvcnRlZA0Ka2VybmVsIEJVRyBhdCBkcml2ZXJz
L2Jhc2UvY29yZS5jOjI2OSENCmludmFsaWQgb3BlcmFuZDogMDAwMA0KQ1BV
OiAgICAwDQpFSVA6ICAgIDAwNjA6WzxjMDFlMmQ5MD5dICAgIE5vdCB0YWlu
dGVkDQpVc2luZyBkZWZhdWx0cyBmcm9tIGtzeW1vb3BzIC10IGVsZjMyLWkz
ODYgLWEgaTM4Ng0KRUZMQUdTOiAwMDAxMDIwMg0KZWF4OiAwMDAwMDAwMSAg
IGVieDogY2Y1M2I5NjQgICBlY3g6IGMwM2VlNWQwICAgZWR4OiBjZjUzYjlm
Yw0KZXNpOiBjZjk0OGM5OCAgIGVkaTogY2Y5NDhjMDAgICBlYnA6IGQwOGJm
MmUwICAgZXNwOiBjZjYwZmYxNA0KZHM6IDAwNjggICBlczogMDA2OCAgIHNz
OiAwMDY4DQpTdGFjazogMDAwMDAwMDAgY2Y1M2I4MDAgYzAyMmI4YzkgY2Y1
M2I5NjQgZmZmZmZmZjQgY2ZkZTYwMDAgMDAwMDAyODYgYzAxNGZlYmUgDQog
ICAgICAgY2ZkZTYwMDkgMDAwMDAwMDggZmY4ODNlNjAgZmZmZmZmZmUgYzAz
YmRhMDAgMDAwMDAwMDAgYzAxMzhiNGYgYzAxMzhiNjYgDQogICAgICAgYzEy
NTYyYTAgYzEyNTYyYTAgMDAwMDAxZmYgMDAwMDAwMDAgYzAzYmU0MDAgMDAw
MDAwMDAgYzAxMzhlYTIgYzAzYmRhMDAgDQogWzxjMDIyYjhjOT5dIHNjc2lf
dW5yZWdpc3Rlcl9ob3N0KzB4MjU5LzB4NTQwDQogWzxjMDE0ZmViZT5dIGdl
dG5hbWUrMHg1ZS8weGEwDQogWzxjMDEzOGI0Zj5dIGJ1ZmZlcmVkX3JtcXVl
dWUrMHgxMmYvMHgxNTANCiBbPGMwMTM4YjY2Pl0gYnVmZmVyZWRfcm1xdWV1
ZSsweDE0Ni8weDE1MA0KIFs8YzAxMzhlYTI+XSBfX2FsbG9jX3BhZ2VzKzB4
YjIvMHgyOTANCiBbPGQwOGI5ODhhPl0gZXhpdF90aGlzX3Njc2lfZHJpdmVy
KzB4YS8weGMgW25jcjUzYzh4eF0NCiBbPGQwOGJmMmUwPl0gZHJpdmVyX3Rl
bXBsYXRlKzB4MC8weDgwIFtuY3I1M2M4eHhdDQogWzxjMDExYzA3ZT5dIGZy
ZWVfbW9kdWxlKzB4MWUvMHhmMA0KIFs8YzAxMWI0NTQ+XSBzeXNfZGVsZXRl
X21vZHVsZSsweDE1NC8weDJlMA0KIFs8YzAxMDczNmY+XSBzeXNjYWxsX2Nh
bGwrMHg3LzB4Yg0KQ29kZTogMGYgMGIgMGQgMDEgYTMgOTAgMmUgYzAgOGIg
ODMgZDAgMDAgMDAgMDAgODUgYzAgNzQgMDQgNTMgZmYgDQoNCj4+RUlQOyBj
MDFlMmQ5MCA8cHV0X2RldmljZSs1MC84MD4gICA8PT09PT0NCkNvZGU7ICBj
MDFlMmQ5MCA8cHV0X2RldmljZSs1MC84MD4NCjAwMDAwMDAwIDxfRUlQPjoN
CkNvZGU7ICBjMDFlMmQ5MCA8cHV0X2RldmljZSs1MC84MD4gICA8PT09PT0N
CiAgIDA6ICAgMGYgMGIgICAgICAgICAgICAgICAgICAgICB1ZDJhICAgICAg
PD09PT09DQpDb2RlOyAgYzAxZTJkOTIgPHB1dF9kZXZpY2UrNTIvODA+DQog
ICAyOiAgIDBkIDAxIGEzIDkwIDJlICAgICAgICAgICAgb3IgICAgICQweDJl
OTBhMzAxLCVlYXgNCkNvZGU7ICBjMDFlMmQ5NyA8cHV0X2RldmljZSs1Ny84
MD4NCiAgIDc6ICAgYzAgOGIgODMgZDAgMDAgMDAgMDAgICAgICByb3JiICAg
JDB4MCwweGQwODMoJWVieCkNCkNvZGU7ICBjMDFlMmQ5ZSA8cHV0X2Rldmlj
ZSs1ZS84MD4NCiAgIGU6ICAgODUgYzAgICAgICAgICAgICAgICAgICAgICB0
ZXN0ICAgJWVheCwlZWF4DQpDb2RlOyAgYzAxZTJkYTAgPHB1dF9kZXZpY2Ur
NjAvODA+DQogIDEwOiAgIDc0IDA0ICAgICAgICAgICAgICAgICAgICAgamUg
ICAgIDE2IDxfRUlQKzB4MTY+IGMwMWUyZGE2IDxwdXRfZGV2aWNlKzY2Lzgw
Pg0KQ29kZTsgIGMwMWUyZGEyIDxwdXRfZGV2aWNlKzYyLzgwPg0KICAxMjog
ICA1MyAgICAgICAgICAgICAgICAgICAgICAgIHB1c2ggICAlZWJ4DQpDb2Rl
OyAgYzAxZTJkYTMgPHB1dF9kZXZpY2UrNjMvODA+DQogIDEzOiAgIGZmIDAw
ICAgICAgICAgICAgICAgICAgICAgaW5jbCAgICglZWF4KQ0KDQoNCjIgd2Fy
bmluZ3MgaXNzdWVkLiAgUmVzdWx0cyBtYXkgbm90IGJlIHJlbGlhYmxlLg0K

--1170656797-689491880-1035054756=:29078--
