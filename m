Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272158AbTGYPjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272161AbTGYPjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:39:11 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:35335 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S272158AbTGYPiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:38:55 -0400
Date: Fri, 25 Jul 2003 08:53:55 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Ben Collins <bcollins@debian.org>
Cc: Sam Bromley <sbromley@cogeco.ca>, Torrey Hoffman <thoffman@arnor.net>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725155355.GJ23196@ruvolo.net>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Sam Bromley <sbromley@cogeco.ca>,
	Torrey Hoffman <thoffman@arnor.net>, gaxt <gaxt@rogers.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux firewire devel <linux1394-devel@lists.sourceforge.net>
References: <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Content-Disposition: inline
In-Reply-To: <20030725142926.GD1512@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2003 at 10:29:26AM -0400, Ben Collins wrote:
> Yeah. Which is usually the case for a successful ack packet. Something
> is clearing the list of pending packets, but I'm not sure what. Please
> revert the patches thus far and apply this patch. It should tell us
> where pending_packets is getting changed.
>=20
> My best guess right now is that abort_timedouts is killing packets from
> the pending list too quickly. We'll cross that bridge when we see the
> results here.

Interesting.  I think you forgot the patch.  I'm guessing that this is what
it would have looked like.  Output follows.

-Chris


--- ieee1394_core.c.orig.bak    2003-07-25 08:45:41.000000000 -0700
+++ ieee1394_core.c     2003-07-25 08:48:37.000000000 -0700
@@ -952,6 +952,7 @@
         list_for_each_safe(lh, tlh, &llist) {
                 packet =3D list_entry(lh, struct hpsb_packet, list);
                 list_del(&packet->list);
+               HPSB_DEBUG("deleting in abort_requests()");
                 packet->state =3D hpsb_complete;
                 packet->ack_code =3D ACKX_ABORTED;
                 up(&packet->state_change);
@@ -982,6 +983,7 @@
                 packet =3D list_entry(lh, struct hpsb_packet, list);
                next =3D lh->next;
                 if (time_before(packet->sendtime + expire, jiffies)) {
+                       HPSB_DEBUG("abort_timedouts: removing tlabel %d", p=
acket->tlabel);
                         list_del(&packet->list);
                         list_add(&packet->list, &expiredlist);
                 }


ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:00:0b.0
ohci1394_0: Remapped memory spaces reg 0xc897a000
ohci1394_0: Soft reset finished
ohci1394_0: Iso contexts reg: 000000a8 implemented: 000000ff
ohci1394_0: 8 iso receive contexts available
ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394_0: 8 iso transmit contexts available
ohci1394_0: GUID: 00110600:00006a85
ohci1394_0: Receive DMA ctx=3D0 initialized
ohci1394_0: Receive DMA ctx=3D0 initialized
ohci1394_0: Transmit DMA ctx=3D0 initialized
ohci1394_0: Transmit DMA ctx=3D1 initialized
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=3D[10]  MMIO=3D[db001000-db0017ff]  Ma=
x Packet=3D[2048]
ohci1394_0: request csr_rom address: c42a2000
ohci1394_0: IntEvent: 00030010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ohci1394_0: Got RQPkt interrupt status=3D0x00008409
ohci1394_0: SelfID interrupt received (phyid 0, root)
ohci1394_0: SelfID packet 0x807f8956 received
ieee1394: Including SelfID 0x56897f80
ohci1394_0: SelfID for this node is 0x807f8956
ohci1394_0: SelfID complete
ohci1394_0: PhyReqFilter=3Dffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0=
xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=3D0 ... discarded
ieee1394: Initiating ConfigROM request for node 00:1023
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: abort_timedouts: removing tlabel 0
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 60f30404
ieee1394: received packet: ffc00160 ffc00000 00000000 60f30404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 60f30404
ieee1394: send packet local: ffc00540 ffc0ffff f0000400
ieee1394: abort_timedouts: removing tlabel 1
ieee1394: received packet: ffc00540 ffc0ffff f0000400
ieee1394: send packet local: ffc00560 ffc00000 00000000 60f30404
ieee1394: received packet: ffc00560 ffc00000 00000000 60f30404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 60f30404
ieee1394: send packet local: ffc00940 ffc0ffff f0000400
ieee1394: abort_timedouts: removing tlabel 2
ieee1394: received packet: ffc00940 ffc0ffff f0000400
ieee1394: send packet local: ffc00960 ffc00000 00000000 60f30404
ieee1394: received packet: ffc00960 ffc00000 00000000 60f30404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00960 ffc00000 00000000 60f30404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394_0: Inserting packet for node 63:1023, tlabel=3D0, tcode=3D0x0, spe=
ed=3D0
ohci1394_0: Starting transmit DMA ctx=3D0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=3D0x00008011
ohci1394_0: Packet sent to node 63 tcode=3D0x0 tLabel=3D0x00 ack=3D0x11 spd=
=3D0 data=3D0x1F0000C0 ctx=3D0


--72k7VsmfIboquFwl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IVKTKO6EG1hc77ERAg1cAKDoOOHc7Q3Cs1kUF7ui2qtMxWluZACg3JZ1
y8kxbroLUambw/6KH3tFUaM=
=sUVO
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--
