Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVADME7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVADME7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 07:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVADME7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 07:04:59 -0500
Received: from pop.gmx.net ([213.165.64.20]:63376 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261365AbVADMEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 07:04:49 -0500
Date: Tue, 4 Jan 2005 13:04:47 +0100 (MET)
From: "John Moretti" <j.moretti@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary140021104840287"
Subject: VIA IDE - dma_timer_expiry - 2.4.28
X-Priority: 3 (Normal)
X-Authenticated: #11156181
Message-ID: <14002.1104840287@www3.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary140021104840287
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi there,

I'm having all kinds of odd issues IDE on these VIA chipsets (VIA C3
 mini-itx machines). After a certain amount of time (goes from one 
hour to a month) the harddrive (or the whole ide subsystem?) 
will go nuts with the following messages, which I've finally managed 
to capture through a serial console. The machine doesn't hardlock 
but it's impossible to launch any command or reboot the machine remotely.
I've even tried with "ide0=serialize ide1=serialize",
since I read on this list that these options would cure most of the 
obscure IDE setups, but the problem still persists. 
I've reproduced this problem with all of the 2.4.2[4-8] series 
and also with 2.6.3 (which is the only one I tried some time ago).
I attach the error messages, lspci and lsmod (kernel is 
compiled with CONFIG_BLK_DEV_VIA82CXXX=y).

- Error messages:
hdc: dma_timer_expiry: dma status == 0x20
hdc: timeout waiting for DMA
hdc: timeout waiting for DMA
hdc: (__ide_dma_test_irq) called while not waiting
hdc: status timeout: status=0xd0 { Busy }
hdc: drive not ready for command
ide1: reset timed-out, status=0xd0
hdc: status timeout: status=0xd0 { Busy }
hdc: drive not ready for command
ide1: reset timed-out, status=0xd0
end_request: I/O error, dev 16:07 (hdc), sector 12845088
end_request: I/O error, dev 16:07 (hdc), sector 13369384
end_request: I/O error, dev 16:07 (hdc), sector 14155808
end_request: I/O error, dev 16:07 (hdc), sector 14417960
end_request: I/O error, dev 16:07 (hdc), sector 14942240
end_request: I/O error, dev 16:07 (hdc), sector 14942248
end_request: I/O error, dev 16:07 (hdc), sector 15204392
end_request: I/O error, dev 16:07 (hdc), sector 15466536
end_request: I/O error, dev 16:07 (hdc), sector 16252968

<snip similar lines>

end_request: I/O error, dev 16:07 (hdc), sector 19472
end_request: I/O error, dev 16:07 (hdc), sector 19480
end_request: I/O error, dev 16:07 (hdc), sector 14942240
EXT3-fs error (device ide1(22,7)): ext3_get_inode_loc: unable to read inode
block - inode=928422, block=1867780
end_request: I/O error, dev 16:07 (hdc), sector 0
end_request: I/O error, dev 16:07 (hdc), sector 19488
EXT3-fs error (device ide1(22,7)) in ext3_reserve_inode_write: IO failure
end_request: I/O error, dev 16:07 (hdc), sector 0
end_request: I/O error, dev 16:07 (hdc), sector 14155808
EXT3-fs error (device ide1(22,7)): ext3_get_inode_loc: unable to read inode
block - inode=879555, block=1769476
end_request: I/O error, dev 16:07 (hdc), sector 0
EXT3-fs error (device ide1(22,7)) in ext3_reserve_inode_write: IO failure

<snip similar pattern>

end_request: I/O error, dev 16:07 (hdc), sector 0
end_request: I/O error, dev 16:07 (hdc), sector 270256
end_request: I/O error, dev 16:07 (hdc), sector 20616
end_request: I/O error, dev 16:07 (hdc), sector 20624
end_request: I/O error, dev 16:07 (hdc), sector 20632
end_request: I/O error, dev 16:07 (hdc), sector 20640
end_request: I/O error, dev 16:07 (hdc), sector 20648
journal_bmap_R65dbd63b: journal block not found at offset 2060 on ide1(22,7)
Aborting journal on device ide1(22,7).
end_request: I/O error, dev 16:07 (hdc), sector 4144
end_request: I/O error, dev 16:07 (hdc), sector 0
end_request: I/O error, dev 16:07 (hdc), sector 8
end_request: I/O error, dev 16:07 (hdc), sector 262168
ext3_abort called.
EXT3-fs abort (device ide1(22,7)): ext3_journal_start: Detected aborted
journal



- Relevant IDE dmesg:
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
hdc: IC25N020ATCS04-0, ATA DISK drive
blk: queue c032ad4c, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(33)
Partition check:
 hdc: hdc1 hdc2 hdc3 < hdc5 hdc6 hdc7 >
ide: late registration of driver.

- Lsmod:
Module                  Size  Used by    Not tainted
8139too                12928   1
mii                     2368   0  [8139too]
ext3                   64320   4
jbd                    46684   4  [ext3]

Since I have about half a dozen of machines that fail this way, I was 
wondering if it is a H/W problem or something else. 
Thanks for any hints on how to debug further this problem.
John

ps. I'm not subscribed please CC: me

-- 
+++ Sparen Sie mit GMX DSL +++ http://www.gmx.net/de/go/dsl
AKTION für Wechsler: DSL-Tarife ab 3,99 EUR/Monat + Startguthaben
--========GMXBoundary140021104840287
Content-Type: text/plain; name="lspci.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lspci.txt"

MDA6MDAuMCBIb3N0IGJyaWRnZTogVklBIFRlY2hub2xvZ2llcywgSW5jLiBWVDg2MDEgW0Fwb2xs
byBQcm9NZWRpYV0gKHJldiAwNSkKCVN1YnN5c3RlbTogVklBIFRlY2hub2xvZ2llcywgSW5jLiBW
VDg2MDEgW0Fwb2xsbyBQcm9NZWRpYV0KCUZsYWdzOiBidXMgbWFzdGVyLCBtZWRpdW0gZGV2c2Vs
LCBsYXRlbmN5IDgKCU1lbW9yeSBhdCBlMDAwMDAwMCAoMzItYml0LCBwcmVmZXRjaGFibGUpIFtz
aXplPTY0TV0KCUNhcGFiaWxpdGllczogW2EwXSBBR1AgdmVyc2lvbiAyLjAKCjAwOjAxLjAgUENJ
IGJyaWRnZTogVklBIFRlY2hub2xvZ2llcywgSW5jLiBWVDg2MDEgW0Fwb2xsbyBQcm9NZWRpYSBB
R1BdIChwcm9nLWlmIDAwIFtOb3JtYWwgZGVjb2RlXSkKCUZsYWdzOiBidXMgbWFzdGVyLCA2Nk1o
eiwgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAwCglCdXM6IHByaW1hcnk9MDAsIHNlY29uZGFyeT0w
MSwgc3Vib3JkaW5hdGU9MDEsIHNlYy1sYXRlbmN5PTAKCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiBl
NDAwMDAwMC1lNTdmZmZmZgoJQ2FwYWJpbGl0aWVzOiBbODBdIFBvd2VyIE1hbmFnZW1lbnQgdmVy
c2lvbiAyCgowMDowNy4wIElTQSBicmlkZ2U6IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ4MkM2
ODYgW0Fwb2xsbyBTdXBlciBTb3V0aF0gKHJldiA0MCkKCVN1YnN5c3RlbTogVklBIFRlY2hub2xv
Z2llcywgSW5jLiBWVDgyQzY4Ni9BIFBDSSB0byBJU0EgQnJpZGdlCglGbGFnczogYnVzIG1hc3Rl
ciwgc3RlcHBpbmcsIG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgMAoJQ2FwYWJpbGl0aWVzOiBbYzBd
IFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgowMDowNy4xIElERSBpbnRlcmZhY2U6IFZJQSBU
ZWNobm9sb2dpZXMsIEluYy4gQnVzIE1hc3RlciBJREUgKHJldiAwNikgKHByb2ctaWYgOGEgW01h
c3RlciBTZWNQIFByaVBdKQoJU3Vic3lzdGVtOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIEJ1cyBN
YXN0ZXIgSURFCglGbGFnczogYnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAzMgoJ
SS9PIHBvcnRzIGF0IGMwMDAgW3NpemU9MTZdCglDYXBhYmlsaXRpZXM6IFtjMF0gUG93ZXIgTWFu
YWdlbWVudCB2ZXJzaW9uIDIKCjAwOjA3LjIgVVNCIENvbnRyb2xsZXI6IFZJQSBUZWNobm9sb2dp
ZXMsIEluYy4gVUhDSSBVU0IgKHJldiAxYSkgKHByb2ctaWYgMDAgW1VIQ0ldKQoJU3Vic3lzdGVt
OiBVbmtub3duIGRldmljZSAwOTI1OjEyMzQKCUZsYWdzOiBidXMgbWFzdGVyLCBtZWRpdW0gZGV2
c2VsLCBsYXRlbmN5IDMyLCBJUlEgMTIKCUkvTyBwb3J0cyBhdCBjNDAwIFtzaXplPTMyXQoJQ2Fw
YWJpbGl0aWVzOiBbODBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgowMDowNy4zIFVTQiBD
b250cm9sbGVyOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFVIQ0kgVVNCIChyZXYgMWEpIChwcm9n
LWlmIDAwIFtVSENJXSkKCVN1YnN5c3RlbTogVW5rbm93biBkZXZpY2UgMDkyNToxMjM0CglGbGFn
czogYnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAzMiwgSVJRIDEyCglJL08gcG9y
dHMgYXQgYzgwMCBbc2l6ZT0zMl0KCUNhcGFiaWxpdGllczogWzgwXSBQb3dlciBNYW5hZ2VtZW50
IHZlcnNpb24gMgoKMDA6MDcuNCBCcmlkZ2U6IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ4MkM2
ODYgW0Fwb2xsbyBTdXBlciBBQ1BJXSAocmV2IDQwKQoJU3Vic3lzdGVtOiBWSUEgVGVjaG5vbG9n
aWVzLCBJbmMuIFZUODJDNjg2IFtBcG9sbG8gU3VwZXIgQUNQSV0KCUZsYWdzOiBtZWRpdW0gZGV2
c2VsCglDYXBhYmlsaXRpZXM6IFs2OF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDIKCjAwOjA3
LjUgTXVsdGltZWRpYSBhdWRpbyBjb250cm9sbGVyOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIEFD
OTcgQXVkaW8gQ29udHJvbGxlciAocmV2IDUwKQoJU3Vic3lzdGVtOiBWSUEgVGVjaG5vbG9naWVz
LCBJbmMuIEFDOTcgQXVkaW8gQ29udHJvbGxlcgoJRmxhZ3M6IG1lZGl1bSBkZXZzZWwsIElSUSA1
CglJL08gcG9ydHMgYXQgY2MwMCBbc2l6ZT0yNTZdCglJL08gcG9ydHMgYXQgZDAwMCBbc2l6ZT00
XQoJSS9PIHBvcnRzIGF0IGQ0MDAgW3NpemU9NF0KCUNhcGFiaWxpdGllczogW2MwXSBQb3dlciBN
YW5hZ2VtZW50IHZlcnNpb24gMgoKMDA6MDguMCBFdGhlcm5ldCBjb250cm9sbGVyOiBSZWFsdGVr
IFNlbWljb25kdWN0b3IgQ28uLCBMdGQuIFJUTC04MTM5IChyZXYgMTApCglTdWJzeXN0ZW06IFJl
YWx0ZWsgU2VtaWNvbmR1Y3RvciBDby4sIEx0ZC4gUlQ4MTM5CglGbGFnczogYnVzIG1hc3Rlciwg
bWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAzMiwgSVJRIDEyCglJL08gcG9ydHMgYXQgZDgwMCBbc2l6
ZT0yNTZdCglNZW1vcnkgYXQgZTU4MTAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3Np
emU9MjU2XQoJRXhwYW5zaW9uIFJPTSBhdCA8dW5hc3NpZ25lZD4gW2Rpc2FibGVkXSBbc2l6ZT02
NEtdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDIKCjAwOjA5
LjAgRXRoZXJuZXQgY29udHJvbGxlcjogUmVhbHRlayBTZW1pY29uZHVjdG9yIENvLiwgTHRkLiBS
VEwtODEzOSAocmV2IDEwKQoJU3Vic3lzdGVtOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBM
dGQuIFJUODEzOQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgMzIs
IElSUSAxMAoJSS9PIHBvcnRzIGF0IGRjMDAgW3NpemU9MjU2XQoJTWVtb3J5IGF0IGU1ODExMDAw
ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTI1Nl0KCUV4cGFuc2lvbiBST00gYXQg
PHVuYXNzaWduZWQ+IFtkaXNhYmxlZF0gW3NpemU9NjRLXQoJQ2FwYWJpbGl0aWVzOiBbNTBdIFBv
d2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgowMDowYi4wIEV0aGVybmV0IGNvbnRyb2xsZXI6IFJl
YWx0ZWsgU2VtaWNvbmR1Y3RvciBDby4sIEx0ZC4gUlRMLTgxMzkgKHJldiAxMCkKCVN1YnN5c3Rl
bTogUmVhbHRlayBTZW1pY29uZHVjdG9yIENvLiwgTHRkLiBSVDgxMzkKCUZsYWdzOiBidXMgbWFz
dGVyLCBtZWRpdW0gZGV2c2VsLCBsYXRlbmN5IDMyLCBJUlEgMTEKCUkvTyBwb3J0cyBhdCBlMDAw
IFtzaXplPTI1Nl0KCU1lbW9yeSBhdCBlNTgxMjAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT0yNTZdCglFeHBhbnNpb24gUk9NIGF0IDx1bmFzc2lnbmVkPiBbZGlzYWJsZWRdIFtz
aXplPTY0S10KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMgoK
MDE6MDAuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBUcmlkZW50IE1pY3Jvc3lzdGVtcyBD
eWJlckJsYWRlL2kxIChyZXYgNmEpIChwcm9nLWlmIDAwIFtWR0FdKQoJU3Vic3lzdGVtOiBUcmlk
ZW50IE1pY3Jvc3lzdGVtcyBDeWJlckJsYWRlL2kxCglGbGFnczogYnVzIG1hc3RlciwgNjZNaHos
IG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgMzIsIElSUSAxMgoJTWVtb3J5IGF0IGU0MDAwMDAwICgz
Mi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPThNXQoJTWVtb3J5IGF0IGU1MDAwMDAwICgz
Mi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTEyOEtdCglNZW1vcnkgYXQgZTQ4MDAwMDAg
KDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9OE1dCglFeHBhbnNpb24gUk9NIGF0IDx1
bmFzc2lnbmVkPiBbZGlzYWJsZWRdIFtzaXplPTY0S10KCUNhcGFiaWxpdGllczogWzgwXSBBR1Ag
dmVyc2lvbiAyLjAKCUNhcGFiaWxpdGllczogWzkwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24g
MQoK

--========GMXBoundary140021104840287--

