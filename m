Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTEJT35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTEJT35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:29:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:58885 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264478AbTEJT3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:29:22 -0400
Date: Sat, 10 May 2003 21:39:06 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [USB] [PATCH] Crud-- (was: Re: [ATM] [UPDATE] unbalanced usw)
Message-ID: <20030510213906.A17835@electric-eye.fr.zoreil.com>
References: <20030510062015.A21408@infradead.org> <200305101352.h4ADqoGi014392@locutus.cmf.nrl.navy.mil> <20030510161219.GB5580@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030510161219.GB5580@kroah.com>; from greg@kroah.com on Sat, May 10, 2003 at 09:12:19AM -0700
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: list modified]

Greg KH <greg@kroah.com> :
[...]
> Not at all.  I'll gladly take patches to fix this crud up.

What about the following patch ?


 usb/host/ehci-q.c              |    0 
 drivers/usb/class/cdc-acm.c    |   42 +++--
 drivers/usb/class/usb-midi.c   |   62 +++++--
 drivers/usb/class/usblp.c      |   28 ++-
 drivers/usb/core/hcd-pci.c     |    3 
 drivers/usb/host/ohci-sa1111.c |    6 
 drivers/usb/input/hid-core.c   |   32 ++-
 drivers/usb/input/hid-input.c  |    3 
 drivers/usb/input/hid-lgff.c   |    6 
 drivers/usb/input/hid-tmff.c   |    3 
 drivers/usb/input/hiddev.c     |   27 ++-
 drivers/usb/input/pid.c        |    6 
 drivers/usb/input/usbkbd.c     |    3 
 drivers/usb/media/ov511.c      |  332 +++++++++++++++++++++++++----------------
 drivers/usb/media/se401.c      |   19 +-
 drivers/usb/media/vicam.c      |    3 
 drivers/usb/misc/auerswald.c   |   33 ++--
 drivers/usb/net/catc.c         |   12 -
 drivers/usb/net/kaweth.c       |    3 
 drivers/usb/serial/belkin_sa.c |    7 
 drivers/usb/serial/console.c   |    9 -
 drivers/usb/serial/cyberjack.c |    9 -
 drivers/usb/serial/io_ti.c     |    3 
 drivers/usb/serial/ir-usb.c    |    3 
 24 files changed, 417 insertions(+), 237 deletions(-)

diff -puN drivers/usb/class/usb-midi.c~codingstyle-patrol-usb drivers/usb/class/usb-midi.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/class/usb-midi.c~codingstyle-patrol-usb	Sat May 10 20:34:14 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/class/usb-midi.c	Sat May 10 21:29:42 2003
@@ -1355,8 +1355,10 @@ static struct usb_midi_device *parse_des
 		next = p2 + p2[0];
 		length -= p2[0];
 
-		if (p2[0] < 2 ) break;
-		if (p2[1] != USB_DT_CS_INTERFACE) break;
+		if (p2[0] < 2 )
+			break;
+		if (p2[1] != USB_DT_CS_INTERFACE)r
+			break;
 		if (p2[2] == MIDI_IN_JACK && p2[0] >= 6 ) {
 			jack = p2[4];
 #ifdef HAVE_JACK_STRINGS
@@ -1366,7 +1368,8 @@ static struct usb_midi_device *parse_des
 			       jack, (p2[3] == EMBEDDED_JACK)?"EMBEDDED":"EXTERNAL" );
 		} else if ( p2[2] == MIDI_OUT_JACK && p2[0] >= 6) {
 			pins = p2[5];
-			if ( p2[0] < (6 + 2 * pins) ) continue;
+			if ( p2[0] < (6 + 2 * pins) )
+				continue;
 			jack = p2[4];
 #ifdef HAVE_JACK_STRINGS
 			jack2string[jack] = p2[5 + 2 * pins];
@@ -1375,9 +1378,11 @@ static struct usb_midi_device *parse_des
 			       jack, (p2[3] == EMBEDDED_JACK)?"EMBEDDED":"EXTERNAL", pins );
 		} else if ( p2[2] == ELEMENT_DESCRIPTOR  && p2[0]  >= 10) {
 			pins = p2[4];
-			if ( p2[0] < (9 + 2 * pins ) ) continue;
+			if ( p2[0] < (9 + 2 * pins ) )
+				continue;
 			nbytes = p2[8 + 2 * pins ];
-			if ( p2[0] < (10 + 2 * pins + nbytes) ) continue;
+			if ( p2[0] < (10 + 2 * pins + nbytes) )
+				continue;
 			longBits = 0L;
 			for ( offset = 0, shift = 0; offset < nbytes && offset < 8; offset ++, shift += 8) {
 				longBits |= ((long)(p2[9 + 2 * pins + offset])) << shift;
@@ -1408,7 +1413,8 @@ static struct usb_midi_device *parse_des
 			if ( p2 && next && ( p2 > next ) )
 				p2 = 0;
 
-			if ( p1[0] < 9 || !p2 || p2[0] < 4 ) continue;
+			if ( p1[0] < 9 || !p2 || p2[0] < 4 )
+				continue;
 
 			if ( (p1[2] & 0x80) == 0x80 ) {
 				if ( iep < 15 ) {
@@ -1417,7 +1423,8 @@ static struct usb_midi_device *parse_des
 						pins = 16;
 					u->in[iep].endpoint = p1[2];
 					u->in[iep].cableId = ( 1 << pins ) - 1;
-					if ( u->in[iep].cableId ) iep ++;
+					if ( u->in[iep].cableId )
+						iep ++;
 					if ( iep < 15 ) {
 						u->in[iep].endpoint = -1;
 						u->in[iep].cableId = -1;
@@ -1430,7 +1437,8 @@ static struct usb_midi_device *parse_des
 						pins = 16;
 					u->out[oep].endpoint = p1[2];
 					u->out[oep].cableId = ( 1 << pins ) - 1;
-					if ( u->out[oep].cableId ) oep ++;
+					if ( u->out[oep].cableId )
+						oep ++;
 					if ( oep < 15 ) {
 						u->out[oep].endpoint = -1;
 						u->out[oep].cableId = -1;
@@ -1446,7 +1454,8 @@ static struct usb_midi_device *parse_des
 			next = find_descriptor(buffer, bufSize, p1, USB_DT_ENDPOINT,
 					       ifnum, altSetting ); 
 	
-			if ( p1[0] < 7 ) continue;
+			if ( p1[0] < 7 )
+				continue;
 
 			if ( (p1[2] & 0x80) == 0x80 ) {
 				if ( iep < 15 ) {
@@ -1455,7 +1464,8 @@ static struct usb_midi_device *parse_des
 						pins = 16;
 					u->in[iep].endpoint = p1[2];
 					u->in[iep].cableId = ( 1 << pins ) - 1;
-					if ( u->in[iep].cableId ) iep ++;
+					if ( u->in[iep].cableId )
+						iep ++;
 					if ( iep < 15 ) {
 						u->in[iep].endpoint = -1;
 						u->in[iep].cableId = -1;
@@ -1468,7 +1478,8 @@ static struct usb_midi_device *parse_des
 						pins = 16;
 					u->out[oep].endpoint = p1[2];
 					u->out[oep].cableId = ( 1 << pins ) - 1;
-					if ( u->out[oep].cableId ) oep ++;
+					if ( u->out[oep].cableId )
+						oep ++;
 					if ( oep < 15 ) {
 						u->out[oep].endpoint = -1;
 						u->out[oep].cableId = -1;
@@ -1486,7 +1497,7 @@ static struct usb_midi_device *parse_des
 	return u;
 
 error_end:
-	if ( u ) kfree(u);
+	kfree(u);
 	return NULL;
 }
 
@@ -1501,7 +1512,8 @@ static int on_bits( unsigned short v )
 	int ret=0;
 
 	for ( i=0 ; i<16 ; i++ ) {
-		if ( v & (1<<i) ) ret++;
+		if ( v & (1<<i) )
+			ret++;
 	}
 
 	return ret;
@@ -1578,7 +1590,8 @@ static int alloc_usb_midi_device( struct
 	if ( alt < 0 ) {
 		alt = get_alt_setting( d, u->interface );
 	}
-	if ( alt < 0 ) { return -ENXIO; }
+	if ( alt < 0 )
+		return -ENXIO;
 
 	/* Configure interface */
 	if ( usb_set_interface( d, u->interface, alt ) < 0 ) {
@@ -1596,7 +1609,8 @@ static int alloc_usb_midi_device( struct
 	       && u->in[inEndpoints].cableId >= 0 ) {
 		inDevs += on_bits((unsigned short)u->in[inEndpoints].cableId);
 		mins[inEndpoints] = alloc_midi_in_endpoint( d, u->in[inEndpoints].endpoint );
-		if ( mins[inEndpoints] == NULL ) { goto error_end; }
+		if ( mins[inEndpoints] == NULL )
+			goto error_end;
 		inEndpoints++;
 	}
 
@@ -1605,7 +1619,8 @@ static int alloc_usb_midi_device( struct
 	       && u->out[outEndpoints].cableId >= 0 ) {
 		outDevs += on_bits((unsigned short)u->out[outEndpoints].cableId);
 		mouts[outEndpoints] = alloc_midi_out_endpoint( d, u->out[outEndpoints].endpoint );
-		if ( mouts[outEndpoints] == NULL ) { goto error_end; }
+		if ( mouts[outEndpoints] == NULL )
+			goto error_end;
 		outEndpoints++;
 	}
 
@@ -1707,7 +1722,8 @@ static int alloc_usb_midi_device( struct
 		mout = mouts[outEndpoint];
 
 		mdevs[i] = allocMidiDev( s, min, mout, inCableId, outCableId );
-		if ( mdevs[i] == NULL ) { goto error_end; }
+		if ( mdevs[i] == NULL )
+			goto error_end;
 
 	}
 
@@ -1962,11 +1978,15 @@ static int detect_by_hand(struct usb_dev
 		return -EINVAL;
 	}
 
-	if ( ualt < 0 ) { ualt = -1; }
+	if ( ualt < 0 )
+		ualt = -1;
 
-	if ( umin   < 0 || umin   > 15 ) { umin   = 0x01 | USB_DIR_IN; }
-	if ( umout  < 0 || umout  > 15 ) { umout  = 0x01; }
-	if ( ucable < 0 || ucable > 15 ) { ucable = 0; }
+	if ( umin   < 0 || umin   > 15 )
+		umin   = 0x01 | USB_DIR_IN;
+	if ( umout  < 0 || umout  > 15 )
+		umout  = 0x01;
+	if ( ucable < 0 || ucable > 15 )
+		ucable = 0;
 
 	u.deviceName = 0; /* A flag for alloc_usb_midi_device to get device name
 			     from device. */
diff -puN drivers/usb/host/ehci-q.c~codingstyle-patrol-usb drivers/usb/host/ehci-q.c
diff -puN drivers/usb/media/se401.c~codingstyle-patrol-usb drivers/usb/media/se401.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/media/se401.c~codingstyle-patrol-usb	Sat May 10 20:40:13 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/media/se401.c	Sat May 10 20:48:15 2003
@@ -170,7 +170,8 @@ static int se401_read_proc(char *page, c
 	len -= off;
 	if (len < count) {
 		*eof = 1;
-			if (len <= 0) return 0;
+		if (len <= 0)
+			return 0;
 	} else
 		len = count;
 
@@ -749,7 +750,8 @@ static inline void decode_JangGu_vlc (st
 				}
 			} else {
 				if (vlc_cod==2) {
-					if (!bit) vlc_data=-(1<<vlc_size)+1;
+					if (!bit)
+						vlc_data =  -(1<<vlc_size) + 1;
 					vlc_cod--;
 				}
 				vlc_size--;
@@ -1046,15 +1048,12 @@ static int se401_open(struct inode *inod
 
 	if (se401->user)
 		return -EBUSY;
-	se401->user=1;
-	se401->fbuf=rvmalloc(se401->maxframesize * SE401_NUMFRAMES);
-	if(!se401->fbuf) err=-ENOMEM;
-
-        if (0 != err) {
-		se401->user = 0;
-	} else {
+	se401->fbuf = rvmalloc(se401->maxframesize * SE401_NUMFRAMES);
+	if (se401->fbuf)
 		file->private_data = dev;
-	}
+	else 
+		err = -ENOMEM;
+	se401->user = !err;
 
 	return err;
 }
diff -puN drivers/usb/serial/ir-usb.c~codingstyle-patrol-usb drivers/usb/serial/ir-usb.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/serial/ir-usb.c~codingstyle-patrol-usb	Sat May 10 20:43:44 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/serial/ir-usb.c	Sat May 10 20:44:14 2003
@@ -461,7 +461,8 @@ static void ir_read_bulk_callback (struc
 			 * contains a busy indicator and baud rate change.
 			 * See section 5.4.1.2 of the USB IrDA spec.
 			 */
-			if((*data & 0x0f) > 0) ir_baud = *data & 0x0f;
+			if ((*data & 0x0f) > 0)
+				ir_baud = *data & 0x0f;
 
 			usb_serial_debug_data (
 				__FILE__,
diff -puN drivers/usb/serial/cyberjack.c~codingstyle-patrol-usb drivers/usb/serial/cyberjack.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/serial/cyberjack.c~codingstyle-patrol-usb	Sat May 10 20:44:19 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/serial/cyberjack.c	Sat May 10 21:17:00 2003
@@ -284,7 +284,8 @@ static void cyberjack_read_int_callback(
 	struct usb_serial *serial;
 	unsigned char *data = urb->transfer_buffer;
 
-	if (port_paranoia_check (port, __FUNCTION__)) return;
+	if (port_paranoia_check (port, __FUNCTION__))
+		return;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
@@ -293,7 +294,8 @@ static void cyberjack_read_int_callback(
 		return;
 
 	serial = port->serial;
-	if (serial_paranoia_check (serial, __FUNCTION__)) return;
+	if (serial_paranoia_check (serial, __FUNCTION__))
+		return;
 
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, data);
 
@@ -372,7 +374,8 @@ static void cyberjack_read_bulk_callback
 	/* Reduce urbs to do by one. */
 	priv->rdtodo-=urb->actual_length;
 	/* Just to be sure */
-	if( priv->rdtodo<0 ) priv->rdtodo=0;
+	if ( priv->rdtodo<0 )
+		priv->rdtodo = 0;
 
 	dbg("%s - rdtodo: %d", __FUNCTION__, priv->rdtodo);
 
diff -puN drivers/usb/net/kaweth.c~codingstyle-patrol-usb drivers/usb/net/kaweth.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/net/kaweth.c~codingstyle-patrol-usb	Sat May 10 20:45:15 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/net/kaweth.c	Sat May 10 20:45:47 2003
@@ -811,7 +811,8 @@ static void kaweth_async_set_rx_mode(str
 {
 	__u16 packet_filter_bitmap = kaweth->packet_filter_bitmap;
 	kaweth->packet_filter_bitmap = 0;
-	if(packet_filter_bitmap == 0) return;
+	if (packet_filter_bitmap == 0)
+		return;
 
 	{
 	int result;
diff -puN drivers/usb/media/ov511.c~codingstyle-patrol-usb drivers/usb/media/ov511.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/media/ov511.c~codingstyle-patrol-usb	Sat May 10 20:48:21 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/media/ov511.c	Sat May 10 21:13:45 2003
@@ -876,15 +876,18 @@ ov518_i2c_write_internal(struct usb_ov51
 
 	/* Select camera register */
 	rc = reg_w(ov, R51x_I2C_SADDR_3, reg);
-	if (rc < 0) return rc;
+	if (rc < 0)
+		return rc;
 
 	/* Write "value" to I2C data port of OV511 */
 	rc = reg_w(ov, R51x_I2C_DATA, value);
-	if (rc < 0) return rc;
+	if (rc < 0)
+		return rc;
 
 	/* Initiate 3-byte write cycle */
 	rc = reg_w(ov, R518_I2C_CTL, 0x01);
-	if (rc < 0) return rc;
+	if (rc < 0)
+		return rc;
 
 	return 0;
 }
@@ -903,33 +906,43 @@ ov511_i2c_write_internal(struct usb_ov51
 	for (retries = OV511_I2C_RETRIES; ; ) {
 		/* Select camera register */
 		rc = reg_w(ov, R51x_I2C_SADDR_3, reg);
-		if (rc < 0) return rc;
+		if (rc < 0)
+			break;
 
 		/* Write "value" to I2C data port of OV511 */
 		rc = reg_w(ov, R51x_I2C_DATA, value);
-		if (rc < 0) return rc;
+		if (rc < 0)
+			break;
 
 		/* Initiate 3-byte write cycle */
 		rc = reg_w(ov, R511_I2C_CTL, 0x01);
-		if (rc < 0) return rc;
+		if (rc < 0)
+			break;
 
-		do rc = reg_r(ov, R511_I2C_CTL);
-		while (rc > 0 && ((rc&1) == 0)); /* Retry until idle */
-		if (rc < 0) return rc;
+		/* Retry until idle */
+		do
+			rc = reg_r(ov, R511_I2C_CTL);
+		while (rc > 0 && ((rc&1) == 0)); 
+		if (rc < 0)
+			break;
 
-		if ((rc&2) == 0) /* Ack? */
+		/* Ack? */
+		if ((rc&2) == 0) {
+			rc = 0;
 			break;
+		}
 #if 0
 		/* I2C abort */
 		reg_w(ov, R511_I2C_CTL, 0x10);
 #endif
 		if (--retries < 0) {
 			err("i2c write retries exhausted");
-			return -1;
+			rc = -1;
+			break;
 		}
 	}
 
-	return 0;
+	return rc;
 }
 
 /* NOTE: Do not call this function directly!
@@ -944,15 +957,18 @@ ov518_i2c_read_internal(struct usb_ov511
 
 	/* Select camera register */
 	rc = reg_w(ov, R51x_I2C_SADDR_2, reg);
-	if (rc < 0) return rc;
+	if (rc < 0)
+		return rc;
 
 	/* Initiate 2-byte write cycle */
 	rc = reg_w(ov, R518_I2C_CTL, 0x03);
-	if (rc < 0) return rc;
+	if (rc < 0)
+		return rc;
 
 	/* Initiate 2-byte read cycle */
 	rc = reg_w(ov, R518_I2C_CTL, 0x05);
-	if (rc < 0) return rc;
+	if (rc < 0)
+		return rc;
 
 	value = reg_r(ov, R51x_I2C_DATA);
 
@@ -972,15 +988,20 @@ ov511_i2c_read_internal(struct usb_ov511
 	for (retries = OV511_I2C_RETRIES; ; ) {
 		/* Select camera register */
 		rc = reg_w(ov, R51x_I2C_SADDR_2, reg);
-		if (rc < 0) return rc;
+		if (rc < 0)
+			return rc;
 
 		/* Initiate 2-byte write cycle */
 		rc = reg_w(ov, R511_I2C_CTL, 0x03);
-		if (rc < 0) return rc;
+		if (rc < 0)
+			return rc;
 
-		do rc = reg_r(ov, R511_I2C_CTL);
-		while (rc > 0 && ((rc&1) == 0)); /* Retry until idle */
-		if (rc < 0) return rc;
+		/* Retry until idle */
+		do
+			 rc = reg_r(ov, R511_I2C_CTL);
+		while (rc > 0 && ((rc&1) == 0));
+		if (rc < 0)
+			return rc;
 
 		if ((rc&2) == 0) /* Ack? */
 			break;
@@ -998,18 +1019,23 @@ ov511_i2c_read_internal(struct usb_ov511
 	for (retries = OV511_I2C_RETRIES; ; ) {
 		/* Initiate 2-byte read cycle */
 		rc = reg_w(ov, R511_I2C_CTL, 0x05);
-		if (rc < 0) return rc;
+		if (rc < 0)
+			return rc;
 
-		do rc = reg_r(ov, R511_I2C_CTL);
-		while (rc > 0 && ((rc&1) == 0)); /* Retry until idle */
-		if (rc < 0) return rc;
+		/* Retry until idle */
+		do
+			rc = reg_r(ov, R511_I2C_CTL);
+		while (rc > 0 && ((rc&1) == 0));
+		if (rc < 0)
+			return rc;
 
 		if ((rc&2) == 0) /* Ack? */
 			break;
 
 		/* I2C abort */
 		rc = reg_w(ov, R511_I2C_CTL, 0x10);
-		if (rc < 0) return rc;
+		if (rc < 0)
+			return rc;
 
 		if (--retries < 0) {
 			err("i2c read retries exhausted");
@@ -1127,10 +1153,12 @@ i2c_set_slave_internal(struct usb_ov511 
 	int rc;
 
 	rc = reg_w(ov, R51x_I2C_W_SID, slave);
-	if (rc < 0) return rc;
+	if (rc < 0)
+		return rc;
 
 	rc = reg_w(ov, R51x_I2C_R_SID, slave + 1);
-	if (rc < 0) return rc;
+	if (rc < 0)
+		return rc;
 
 	return 0;
 }
@@ -1149,7 +1177,8 @@ i2c_w_slave(struct usb_ov511 *ov,
 
 	/* Set new slave IDs */
 	rc = i2c_set_slave_internal(ov, slave);
-	if (rc < 0) goto out;
+	if (rc < 0)
+		goto out;
 
 	rc = ov51x_i2c_write_mask_internal(ov, reg, value, mask);
 
@@ -1174,7 +1203,8 @@ i2c_r_slave(struct usb_ov511 *ov,
 
 	/* Set new slave IDs */
 	rc = i2c_set_slave_internal(ov, slave);
-	if (rc < 0) goto out;
+	if (rc < 0)
+		goto out;
 
 	if (ov->bclass == BCL_OV518)
 		rc = ov518_i2c_read_internal(ov, reg);
@@ -1199,12 +1229,11 @@ ov51x_set_slave_ids(struct usb_ov511 *ov
 	down(&ov->i2c_lock);
 
 	rc = i2c_set_slave_internal(ov, sid);
-	if (rc < 0) goto out;
+	if (rc < 0)
+		goto out;
 
 	// FIXME: Is this actually necessary?
 	rc = ov51x_reset(ov, OV511_RESET_NOREGS);
-	if (rc < 0) goto out;
-
 out:
 	up(&ov->i2c_lock);
 	return rc;
@@ -1403,7 +1432,8 @@ init_ov_sensor(struct usb_ov511 *ov)
 	int i, success;
 
 	/* Reset the sensor */
-	if (i2c_w(ov, 0x12, 0x80) < 0) return -EIO;
+	if (i2c_w(ov, 0x12, 0x80) < 0)
+		return -EIO;
 
 	/* Wait for it to initialize */
 	schedule_timeout(1 + 150 * HZ / 1000);
@@ -1416,11 +1446,13 @@ init_ov_sensor(struct usb_ov511 *ov)
 		}
 
 		/* Reset the sensor */
-		if (i2c_w(ov, 0x12, 0x80) < 0) return -EIO;
+		if (i2c_w(ov, 0x12, 0x80) < 0)
+			return -EIO;
 		/* Wait for it to initialize */
 		schedule_timeout(1 + 150 * HZ / 1000);
 		/* Dummy read to sync I2C */
-		if (i2c_r(ov, 0x00) < 0) return -EIO;
+		if (i2c_r(ov, 0x00) < 0)
+			return -EIO;
 	}
 
 	if (!success)
@@ -1442,24 +1474,37 @@ ov511_set_packet_size(struct usb_ov511 *
 	mult = size >> 5;
 
 	if (ov->bridge == BRG_OV511) {
-		if (size == 0) alt = OV511_ALT_SIZE_0;
-		else if (size == 257) alt = OV511_ALT_SIZE_257;
-		else if (size == 513) alt = OV511_ALT_SIZE_513;
-		else if (size == 769) alt = OV511_ALT_SIZE_769;
-		else if (size == 993) alt = OV511_ALT_SIZE_993;
+		if (size == 0)
+			alt = OV511_ALT_SIZE_0;
+		else if (size == 257)
+			alt = OV511_ALT_SIZE_257;
+		else if (size == 513)
+			alt = OV511_ALT_SIZE_513;
+		else if (size == 769)
+			alt = OV511_ALT_SIZE_769;
+		else if (size == 993)
+			alt = OV511_ALT_SIZE_993;
 		else {
 			err("Set packet size: invalid size (%d)", size);
 			return -EINVAL;
 		}
 	} else if (ov->bridge == BRG_OV511PLUS) {
-		if (size == 0) alt = OV511PLUS_ALT_SIZE_0;
-		else if (size == 33) alt = OV511PLUS_ALT_SIZE_33;
-		else if (size == 129) alt = OV511PLUS_ALT_SIZE_129;
-		else if (size == 257) alt = OV511PLUS_ALT_SIZE_257;
-		else if (size == 385) alt = OV511PLUS_ALT_SIZE_385;
-		else if (size == 513) alt = OV511PLUS_ALT_SIZE_513;
-		else if (size == 769) alt = OV511PLUS_ALT_SIZE_769;
-		else if (size == 961) alt = OV511PLUS_ALT_SIZE_961;
+		if (size == 0)
+			alt = OV511PLUS_ALT_SIZE_0;
+		else if (size == 33)
+			alt = OV511PLUS_ALT_SIZE_33;
+		else if (size == 129)
+			alt = OV511PLUS_ALT_SIZE_129;
+		else if (size == 257)
+			alt = OV511PLUS_ALT_SIZE_257;
+		else if (size == 385)
+			alt = OV511PLUS_ALT_SIZE_385;
+		else if (size == 513)
+			alt = OV511PLUS_ALT_SIZE_513;
+		else if (size == 769)
+			alt = OV511PLUS_ALT_SIZE_769;
+		else if (size == 961)
+			alt = OV511PLUS_ALT_SIZE_961;
 		else {
 			err("Set packet size: invalid size (%d)", size);
 			return -EINVAL;
@@ -1502,14 +1547,22 @@ ov518_set_packet_size(struct usb_ov511 *
 		return -EIO;
 
 	if (ov->bclass == BCL_OV518) {
-		if (size == 0) alt = OV518_ALT_SIZE_0;
-		else if (size == 128) alt = OV518_ALT_SIZE_128;
-		else if (size == 256) alt = OV518_ALT_SIZE_256;
-		else if (size == 384) alt = OV518_ALT_SIZE_384;
-		else if (size == 512) alt = OV518_ALT_SIZE_512;
-		else if (size == 640) alt = OV518_ALT_SIZE_640;
-		else if (size == 768) alt = OV518_ALT_SIZE_768;
-		else if (size == 896) alt = OV518_ALT_SIZE_896;
+		if (size == 0)
+			alt = OV518_ALT_SIZE_0;
+		else if (size == 128)
+			alt = OV518_ALT_SIZE_128;
+		else if (size == 256)
+			alt = OV518_ALT_SIZE_256;
+		else if (size == 384)
+			alt = OV518_ALT_SIZE_384;
+		else if (size == 512)
+			alt = OV518_ALT_SIZE_512;
+		else if (size == 640)
+			alt = OV518_ALT_SIZE_640;
+		else if (size == 768)
+			alt = OV518_ALT_SIZE_768;
+		else if (size == 896)
+			alt = OV518_ALT_SIZE_896;
 		else {
 			err("Set packet size: invalid size (%d)", size);
 			return -EINVAL;
@@ -3939,28 +3992,40 @@ ov51x_init_isoc(struct usb_ov511 *ov)
 	ov->curframe = -1;
 
 	if (ov->bridge == BRG_OV511) {
-		if (cams == 1)				size = 993;
-		else if (cams == 2)			size = 513;
-		else if (cams == 3 || cams == 4)	size = 257;
+		if (cams == 1)
+			size = 993;
+		else if (cams == 2)
+			size = 513;
+		else if (cams == 3 || cams == 4)
+			size = 257;
 		else {
 			err("\"cams\" parameter too high!");
 			return -1;
 		}
 	} else if (ov->bridge == BRG_OV511PLUS) {
-		if (cams == 1)				size = 961;
-		else if (cams == 2)			size = 513;
-		else if (cams == 3 || cams == 4)	size = 257;
-		else if (cams >= 5 && cams <= 8)	size = 129;
-		else if (cams >= 9 && cams <= 31)	size = 33;
+		if (cams == 1)
+			size = 961;
+		else if (cams == 2)
+			size = 513;
+		else if (cams == 3 || cams == 4)
+			size = 257;
+		else if (cams >= 5 && cams <= 8)
+			size = 129;
+		else if (cams >= 9 && cams <= 31)
+			size = 33;
 		else {
 			err("\"cams\" parameter too high!");
 			return -1;
 		}
 	} else if (ov->bclass == BCL_OV518) {
-		if (cams == 1)				size = 896;
-		else if (cams == 2)			size = 512;
-		else if (cams == 3 || cams == 4)	size = 256;
-		else if (cams >= 5 && cams <= 8)	size = 128;
+		if (cams == 1)
+			size = 896;
+		else if (cams == 2)
+			size = 512;
+		else if (cams == 3 || cams == 4)
+			size = 256;
+		else if (cams >= 5 && cams <= 8)
+			size = 128;
 		else {
 			err("\"cams\" parameter too high!");
 			return -1;
@@ -5016,7 +5081,7 @@ ov51x_control_ioctl(struct inode *inode,
 	struct proc_dir_entry *pde = PDE(inode);
 	struct usb_ov511 *ov;
 	void *arg = (void *) ularg;
-	int rc;
+	int rc = 0;
 
 	if (!pde)
 		return -ENOENT;
@@ -5037,81 +5102,79 @@ ov51x_control_ioctl(struct inode *inode,
 
 		PDEBUG(4, "Get interface version: %d", ver);
 		if (copy_to_user(arg, &ver, sizeof(ver)))
-			return -EFAULT;
-
-		return 0;
+			rc = -EFAULT;
+		break;
 	}
 	case OV511IOC_GUSHORT:
 	{
 		struct ov511_ushort_opt opt;
 
-		if (copy_from_user(&opt, arg, sizeof(opt)))
-			return -EFAULT;
+		if (copy_from_user(&opt, arg, sizeof(opt))) {
+			rc = -EFAULT;
+			break;
+		}
 
 		switch (opt.optnum) {
 		case OV511_USOPT_BRIGHT:
 			rc = sensor_get_brightness(ov, &(opt.val));
-			if (rc)	return rc;
 			break;
 		case OV511_USOPT_SAT:
 			rc = sensor_get_saturation(ov, &(opt.val));
-			if (rc)	return rc;
 			break;
 		case OV511_USOPT_HUE:
 			rc = sensor_get_hue(ov, &(opt.val));
-			if (rc)	return rc;
 			break;
 		case OV511_USOPT_CONTRAST:
 			rc = sensor_get_contrast(ov, &(opt.val));
-			if (rc)	return rc;
 			break;
 		default:
 			err("Invalid get short option number");
-			return -EINVAL;
+			rc = -EINVAL;
 		}
 
+		if (rc < 0)
+			break;
 		if (copy_to_user(arg, &opt, sizeof(opt)))
-			return -EFAULT;
-
-		return 0;
+			rc = -EFAULT;
+		break;
 	}
 	case OV511IOC_SUSHORT:
 	{
 		struct ov511_ushort_opt opt;
 
-		if (copy_from_user(&opt, arg, sizeof(opt)))
-			return -EFAULT;
+		if (copy_from_user(&opt, arg, sizeof(opt))) {
+			rc = -EFAULT;
+			break;
+		}
 
 		switch (opt.optnum) {
 		case OV511_USOPT_BRIGHT:
 			rc = sensor_set_brightness(ov, opt.val);
-			if (rc)	return rc;
 			break;
 		case OV511_USOPT_SAT:
 			rc = sensor_set_saturation(ov, opt.val);
-			if (rc)	return rc;
 			break;
 		case OV511_USOPT_HUE:
 			rc = sensor_set_hue(ov, opt.val);
-			if (rc)	return rc;
 			break;
 		case OV511_USOPT_CONTRAST:
 			rc = sensor_set_contrast(ov, opt.val);
-			if (rc)	return rc;
 			break;
 		default:
 			err("Invalid set short option number");
-			return -EINVAL;
+			rc = -EINVAL;
 		}
 
-		return 0;
+		break;
 	}
 	case OV511IOC_GUINT:
 	{
 		struct ov511_uint_opt opt;
 
-		if (copy_from_user(&opt, arg, sizeof(opt)))
-			return -EFAULT;
+		if (copy_from_user(&opt, arg, sizeof(opt))) {
+			rc = -EFAULT;
+			break;
+		}
 
 		switch (opt.optnum) {
 		case OV511_UIOPT_POWER_FREQ:
@@ -5131,29 +5194,31 @@ ov51x_control_ioctl(struct inode *inode,
 			break;
 		default:
 			err("Invalid get int option number");
-			return -EINVAL;
+			rc = -EINVAL;
 		}
 
+		if (rc < 0)
+			break;
 		if (copy_to_user(arg, &opt, sizeof(opt)))
-			return -EFAULT;
+			rc = -EFAULT;
 
-		return 0;
+		break;
 	}
 	case OV511IOC_SUINT:
 	{
 		struct ov511_uint_opt opt;
 
-		if (copy_from_user(&opt, arg, sizeof(opt)))
-			return -EFAULT;
+		if (copy_from_user(&opt, arg, sizeof(opt))) {
+			rc = -EFAULT;
+			break;
+		}
 
 		switch (opt.optnum) {
 		case OV511_UIOPT_POWER_FREQ:
 			rc = sensor_set_light_freq(ov, opt.val);
-			if (rc)	return rc;
 			break;
 		case OV511_UIOPT_BFILTER:
 			rc = sensor_set_banding_filter(ov, opt.val);
-			if (rc)	return rc;
 			break;
 		case OV511_UIOPT_LED:
 			if (opt.val <= 2) {
@@ -5162,15 +5227,14 @@ ov51x_control_ioctl(struct inode *inode,
 					ov51x_led_control(ov, 0);
 				else if (ov->led_policy == LED_ON)
 					ov51x_led_control(ov, 1);
-			} else {
-				return -EINVAL;
-			}
+			} else
+				rc = -EINVAL;
 			break;
 		case OV511_UIOPT_DEBUG:
 			if (opt.val <= 5)
 				debug = opt.val;
 			else
-				return -EINVAL;
+				rc = -EINVAL;
 			break;
 		case OV511_UIOPT_COMPRESS:
 			ov->compress = opt.val;
@@ -5183,43 +5247,48 @@ ov51x_control_ioctl(struct inode *inode,
 			break;
 		default:
 			err("Invalid get int option number");
-			return -EINVAL;
+			rc = -EINVAL;
 		}
 
-		return 0;
+		break;
 	}
 	case OV511IOC_WI2C:
 	{
 		struct ov511_i2c_struct w;
 
-		if (copy_from_user(&w, arg, sizeof(w)))
-			return -EFAULT;
+		if (copy_from_user(&w, arg, sizeof(w))) {
+			rc = -EFAULT;
+			break;
+		}
 
-		return i2c_w_slave(ov, w.slave, w.reg, w.value,	w.mask);
+		rc = i2c_w_slave(ov, w.slave, w.reg, w.value, w.mask);
+		break;
 	}
 	case OV511IOC_RI2C:
 	{
 		struct ov511_i2c_struct r;
 
-		if (copy_from_user(&r, arg, sizeof(r)))
-			return -EFAULT;
+		if (copy_from_user(&r, arg, sizeof(r))) {
+			rc = -EFAULT;
+			break;
+		}
 
 		rc = i2c_r_slave(ov, r.slave, r.reg);
 		if (rc < 0)
-			return rc;
+			break;
 
 		r.value = rc;
 
 		if (copy_to_user(arg, &r, sizeof(r)))
-			return -EFAULT;
+			rc = -EFAULT;
 
-		return 0;
+		break;
 	}
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
 	} /* end switch */
 
-	return 0;
+	return rc;
 }
 #endif
 
@@ -5358,7 +5427,8 @@ ov7xx0_configure(struct usb_ov511 *ov)
 		PDEBUG(1, "OV7xx0 sensor initalized (method 1)");
 	} else {
 		/* Reset the 76xx */
-		if (i2c_w(ov, 0x12, 0x80) < 0) return -1;
+		if (i2c_w(ov, 0x12, 0x80) < 0)
+			return -1;
 
 		/* Wait for it to initialize */
 		schedule_timeout(1 + 150 * HZ / 1000);
@@ -5822,7 +5892,8 @@ ov511_configure(struct usb_ov511 *ov)
 	if (ov->customid == 70)		/* USB Life TV (PAL/SECAM) */
 		ov->pal = 1;
 
-	if (write_regvals(ov, aRegvalsInit511)) goto error;
+	if (write_regvals(ov, aRegvalsInit511))
+		goto error;
 
 	if (ov->led_policy == LED_OFF || ov->led_policy == LED_AUTO)
 		ov51x_led_control(ov, 0);
@@ -5830,14 +5901,17 @@ ov511_configure(struct usb_ov511 *ov)
 	/* The OV511+ has undocumented bits in the flow control register.
 	 * Setting it to 0xff fixes the corruption with moving objects. */
 	if (ov->bridge == BRG_OV511) {
-		if (write_regvals(ov, aRegvalsNorm511)) goto error;
+		if (write_regvals(ov, aRegvalsNorm511))
+			goto error;
 	} else if (ov->bridge == BRG_OV511PLUS) {
-		if (write_regvals(ov, aRegvalsNorm511Plus)) goto error;
+		if (write_regvals(ov, aRegvalsNorm511Plus))
+			goto error;
 	} else {
 		err("Invalid bridge");
 	}
 
-	if (ov511_init_compression(ov)) goto error;
+	if (ov511_init_compression(ov))
+		goto error;
 
 	ov->packet_numbering = 1;
 	ov511_set_packet_size(ov, 0);
@@ -5975,10 +6049,12 @@ ov518_configure(struct usb_ov511 *ov)
 	/* Give it the default description */
 	ov->desc = symbolic(camlist, 0);
 
-	if (write_regvals(ov, aRegvalsInit518)) goto error;
+	if (write_regvals(ov, aRegvalsInit518))
+		goto error;
 
 	/* Set LED GPIO pin to output mode */
-	if (reg_w_mask(ov, 0x57, 0x00, 0x02) < 0) goto error;
+	if (reg_w_mask(ov, 0x57, 0x00, 0x02) < 0)
+		goto error;
 
 	/* LED is off by default with OV518; have to explicitly turn it on */
 	if (ov->led_policy == LED_OFF || ov->led_policy == LED_AUTO)
@@ -5994,16 +6070,20 @@ ov518_configure(struct usb_ov511 *ov)
 	}
 
 	if (ov->bridge == BRG_OV518) {
-		if (write_regvals(ov, aRegvalsNorm518)) goto error;
+		if (write_regvals(ov, aRegvalsNorm518))
+			goto error;
 	} else if (ov->bridge == BRG_OV518PLUS) {
-		if (write_regvals(ov, aRegvalsNorm518Plus)) goto error;
+		if (write_regvals(ov, aRegvalsNorm518Plus))
+			goto error;
 	} else {
 		err("Invalid bridge");
 	}
 
-	if (reg_w(ov, 0x2f, 0x80) < 0) goto error;
+	if (reg_w(ov, 0x2f, 0x80) < 0)
+		goto error;
 
-	if (ov518_init_compression(ov)) goto error;
+	if (ov518_init_compression(ov))
+		goto error;
 
 	if (ov->bridge == BRG_OV518)
 	{
diff -puN drivers/usb/media/vicam.c~codingstyle-patrol-usb drivers/usb/media/vicam.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/media/vicam.c~codingstyle-patrol-usb	Sat May 10 21:14:02 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/media/vicam.c	Sat May 10 21:14:56 2003
@@ -1139,7 +1139,8 @@ vicam_create_proc_entry(struct vicam_cam
 
 	cam->proc_dir = create_proc_entry(name, S_IFDIR, vicam_proc_root);
 
-	if ( !cam->proc_dir ) return; // We should probably return an error here
+	if ( !cam->proc_dir )
+		return; // FIXME: We should probably return an error here
 	
 	ent =
 	    create_proc_entry("shutter", S_IFREG | S_IRUGO, cam->proc_dir);
diff -puN drivers/usb/serial/belkin_sa.c~codingstyle-patrol-usb drivers/usb/serial/belkin_sa.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/serial/belkin_sa.c~codingstyle-patrol-usb	Sat May 10 21:15:33 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/serial/belkin_sa.c	Sat May 10 21:16:10 2003
@@ -285,10 +285,13 @@ static void belkin_sa_read_int_callback 
 		goto exit;
 	}
 
-	if (port_paranoia_check (port, __FUNCTION__)) return;
+	if (port_paranoia_check (port, __FUNCTION__))
+		return;
 
 	serial = port->serial;
-	if (serial_paranoia_check (serial, __FUNCTION__)) return;
+
+	if (serial_paranoia_check (serial, __FUNCTION__))
+		return;
 	
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, data);
 
diff -puN drivers/usb/serial/io_ti.c~codingstyle-patrol-usb drivers/usb/serial/io_ti.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/serial/io_ti.c~codingstyle-patrol-usb	Sat May 10 21:16:16 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/serial/io_ti.c	Sat May 10 21:16:28 2003
@@ -1553,7 +1553,8 @@ static __u8 MapLineStatus (__u8 ti_lsr)
 	__u8 lsr = 0;
 
 #define MAP_FLAG(flagUmp, flagUart)    \
-	if (ti_lsr & flagUmp) lsr |= flagUart;
+	if (ti_lsr & flagUmp)
+		lsr |= flagUart;
 
 	MAP_FLAG(UMP_UART_LSR_OV_MASK, LSR_OVER_ERR)	/* overrun */
 	MAP_FLAG(UMP_UART_LSR_PE_MASK, LSR_PAR_ERR)	/* parity error */
diff -puN drivers/usb/serial/console.c~codingstyle-patrol-usb drivers/usb/serial/console.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/serial/console.c~codingstyle-patrol-usb	Sat May 10 21:17:07 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/serial/console.c	Sat May 10 21:17:35 2003
@@ -76,9 +76,12 @@ static int __init usb_console_setup(stru
 		s = options;
 		while (*s >= '0' && *s <= '9')
 			s++;
-		if (*s)	parity = *s++;
-		if (*s)	bits   = *s++ - '0';
-		if (*s)	doflow = (*s++ == 'r');
+		if (*s)
+			parity = *s++;
+		if (*s)
+			bits   = *s++ - '0';
+		if (*s)
+			doflow = (*s++ == 'r');
 	}
 
 	/* build a cflag setting */
diff -puN drivers/usb/input/usbkbd.c~codingstyle-patrol-usb drivers/usb/input/usbkbd.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/input/usbkbd.c~codingstyle-patrol-usb	Sat May 10 21:17:50 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/input/usbkbd.c	Sat May 10 21:18:04 2003
@@ -137,7 +137,8 @@ int usb_kbd_event(struct input_dev *dev,
 {
 	struct usb_kbd *kbd = dev->private;
 
-	if (type != EV_LED) return -1;
+	if (type != EV_LED)
+		return -1;
 
 
 	kbd->newleds = (!!test_bit(LED_KANA,    dev->led) << 3) | (!!test_bit(LED_COMPOSE, dev->led) << 3) |
diff -puN drivers/usb/input/hid-input.c~codingstyle-patrol-usb drivers/usb/input/hid-input.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/input/hid-input.c~codingstyle-patrol-usb	Sat May 10 21:18:14 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/input/hid-input.c	Sat May 10 21:18:33 2003
@@ -351,7 +351,8 @@ static void hidinput_configure_usage(str
 		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
 	}
 
-	if (usage->code > max) return;
+	if (usage->code > max)
+		return;
 
 	if (usage->type == EV_ABS) {
 		int a = field->logical_minimum;
diff -puN drivers/usb/input/hiddev.c~codingstyle-patrol-usb drivers/usb/input/hiddev.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/input/hiddev.c~codingstyle-patrol-usb	Sat May 10 21:18:36 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/input/hiddev.c	Sat May 10 21:19:49 2003
@@ -96,16 +96,19 @@ hiddev_lookup_report(struct hid_device *
 
 	case HID_REPORT_ID_FIRST:
 		list = report_enum->report_list.next;
-		if (list == &report_enum->report_list) return NULL;
+		if (list == &report_enum->report_list)
+			return NULL;
 		rinfo->report_id = ((struct hid_report *) list)->id;
 		break;
 		
 	case HID_REPORT_ID_NEXT:
 		list = (struct list_head *)
 			report_enum->report_id_hash[rinfo->report_id & HID_REPORT_ID_MASK];
-		if (list == NULL) return NULL;
+		if (list == NULL)
+			return NULL;
 		list = list->next;
-		if (list == &report_enum->report_list) return NULL;
+		if (list == &report_enum->report_list)
+			return NULL;
 		rinfo->report_id = ((struct hid_report *) list)->id;
 		break;
 		
@@ -311,7 +314,8 @@ static ssize_t hiddev_read(struct file *
 	event_size = ((list->flags & HIDDEV_FLAG_UREF) != 0) ?
 		sizeof(struct hiddev_usage_ref) : sizeof(struct hiddev_event);
 
-	if (count < event_size) return 0;
+	if (count < event_size)
+		return 0;
 
 	while (retval == 0) {
 		if (list->head == list->tail) {
@@ -404,7 +408,8 @@ static int hiddev_ioctl(struct inode *in
 	struct hid_field *field;
 	int i;
 
-	if (!hiddev->exist) return -EIO;
+	if (!hiddev->exist)
+		return -EIO;
 
 	switch (cmd) {
 
@@ -646,18 +651,22 @@ static int hiddev_ioctl(struct inode *in
 
 		if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGNAME(0))) {
 			int len;
-			if (!hid->name) return 0;
+			if (!hid->name)
+				return 0;
 			len = strlen(hid->name) + 1;
-			if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
+			if (len > _IOC_SIZE(cmd))
+				 len = _IOC_SIZE(cmd);
 			return copy_to_user((char *) arg, hid->name, len) ?
 				-EFAULT : len;
 		}
 
 		if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGPHYS(0))) {
 			int len;
-			if (!hid->phys) return 0;
+			if (!hid->phys)
+				return 0;
 			len = strlen(hid->phys) + 1;
-			if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
+			if (len > _IOC_SIZE(cmd))
+				len = _IOC_SIZE(cmd);
 			return copy_to_user((char *) arg, hid->phys, len) ?
 				-EFAULT : len;
 		}
diff -puN drivers/usb/input/hid-core.c~codingstyle-patrol-usb drivers/usb/input/hid-core.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/input/hid-core.c~codingstyle-patrol-usb	Sat May 10 21:19:57 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/input/hid-core.c	Sat May 10 21:21:31 2003
@@ -61,7 +61,8 @@ static struct hid_report *hid_register_r
 		return NULL;
 	memset(report, 0, sizeof(struct hid_report));
 
-	if (id != 0) report_enum->numbered = 1;
+	if (id != 0)
+		report_enum->numbered = 1;
 
 	report->id = id;
 	report->type = type;
@@ -539,11 +540,13 @@ static void hid_free_device(struct hid_d
 
 		for (j = 0; j < 256; j++) {
 			struct hid_report *report = report_enum->report_id_hash[j];
-			if (report) hid_free_report(report);
+			if (report)
+				hid_free_report(report);
 		}
 	}
 
-	if (device->rdesc) kfree(device->rdesc);
+	if (device->rdesc)
+		kfree(device->rdesc);
 	kfree(device);
 }
 
@@ -741,7 +744,8 @@ static __inline__ __s32 snto32(__u32 val
 static __inline__ __u32 s32ton(__s32 value, unsigned n)
 {
 	__s32 a = value >> (n - 1);
-	if (a && a != -1) return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
+	if (a && a != -1)
+		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
 	return value & ((1 << n) - 1);
 }
 
@@ -769,7 +773,10 @@ static __inline__ void implement(__u8 *r
 
 static __inline__ int search(__s32 *array, __s32 value, unsigned n)
 {
-	while (n--) if (*array++ == value) return 0;
+	while (n--) {
+		if (*array++ == value)
+			return 0;
+	}
 	return -1;
 }
 
@@ -814,9 +821,11 @@ static void hid_input_field(struct hid_d
 		if (HID_MAIN_ITEM_VARIABLE & field->flags) {
 
 			if (field->flags & HID_MAIN_ITEM_RELATIVE) {
-				if (!value[n]) continue;
+				if (!value[n])
+					continue;
 			} else {
-				if (value[n] == field->value[n]) continue;
+				if (value[n] == field->value[n])
+					continue;
 			}	
 			hid_process_event(hid, field, &field->usage[n], value[n], regs);
 			continue;
@@ -1558,9 +1567,12 @@ static struct hid_device *usb_hid_config
 
 fail:
 
-	if (hid->urbin) usb_free_urb(hid->urbin);
-	if (hid->urbout) usb_free_urb(hid->urbout);
-	if (hid->urbctrl) usb_free_urb(hid->urbctrl);
+	if (hid->urbin)
+		usb_free_urb(hid->urbin);
+	if (hid->urbout)
+		usb_free_urb(hid->urbout);
+	if (hid->urbctrl)
+		usb_free_urb(hid->urbctrl);
 	hid_free_buffers(dev, hid);
 	hid_free_device(hid);
 
diff -puN drivers/usb/input/hid-lgff.c~codingstyle-patrol-usb drivers/usb/input/hid-lgff.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/input/hid-lgff.c~codingstyle-patrol-usb	Sat May 10 21:21:37 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/input/hid-lgff.c	Sat May 10 21:22:20 2003
@@ -154,7 +154,8 @@ int hid_lgff_init(struct hid_device* hid
 	}
 
 	private = kmalloc(sizeof(struct lgff_device), GFP_KERNEL);
-	if (!private) return -1;
+	if (!private)
+		return -1;
 	memset(private, 0, sizeof(struct lgff_device));
 	hid->ff_private = private;
 
@@ -216,7 +217,8 @@ static struct hid_report* hid_lgff_dupli
 	struct hid_report* ret;
 
 	ret = kmalloc(sizeof(struct lgff_device), GFP_KERNEL);
-	if (!ret) return NULL;
+	if (!ret)
+		return NULL;
 	*ret = *report;
 
 	ret->field[0] = kmalloc(sizeof(struct hid_field), GFP_KERNEL);
diff -puN drivers/usb/input/pid.c~codingstyle-patrol-usb drivers/usb/input/pid.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/input/pid.c~codingstyle-patrol-usb	Sat May 10 21:22:30 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/input/pid.c	Sat May 10 21:22:55 2003
@@ -117,7 +117,8 @@ static int hid_pid_erase(struct input_de
 	unsigned wanted_report = HID_UP_PID | FF_PID_USAGE_BLOCK_FREE;  /*  PID Block Free Report */
 	int ret;
 
-	if (!CHECK_OWNERSHIP(id, pid)) return -EACCES;
+	if (!CHECK_OWNERSHIP(id, pid))
+		return -EACCES;
 
 	/* Find report */
 	ret =  hid_find_report_by_usage(hid, wanted_report, &report, HID_OUTPUT_REPORT);
@@ -214,7 +215,8 @@ static int hid_pid_upload_effect(struct 
 	}
 	else {
 		/* We want to update an effect */
-		if (!CHECK_OWNERSHIP(effect->id, pid_private)) return -EACCES;
+		if (!CHECK_OWNERSHIP(effect->id, pid_private))
+			return -EACCES;
 
 		/* Parameter type cannot be updated */
 		if (effect->type != pid_private->effects[effect->id].effect.type)
diff -puN drivers/usb/input/hid-tmff.c~codingstyle-patrol-usb drivers/usb/input/hid-tmff.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/input/hid-tmff.c~codingstyle-patrol-usb	Sat May 10 21:23:02 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/input/hid-tmff.c	Sat May 10 21:23:18 2003
@@ -112,7 +112,8 @@ int hid_tmff_init(struct hid_device *hid
 	struct list_head *pos;
 
 	private = kmalloc(sizeof(struct tmff_device), GFP_KERNEL);
-	if (!private) return -ENOMEM;
+	if (!private)
+		return -ENOMEM;
 
 	memset(private, 0, sizeof(struct tmff_device));
 	hid->ff_private = private;
diff -puN drivers/usb/net/catc.c~codingstyle-patrol-usb drivers/usb/net/catc.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/net/catc.c~codingstyle-patrol-usb	Sat May 10 21:23:26 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/net/catc.c	Sat May 10 21:24:12 2003
@@ -828,10 +828,14 @@ static int catc_probe(struct usb_interfa
 	if ((!catc->ctrl_urb) || (!catc->tx_urb) || 
 	    (!catc->rx_urb) || (!catc->irq_urb)) {
 		err("No free urbs available.");
-		if (catc->ctrl_urb) usb_free_urb(catc->ctrl_urb);
-		if (catc->tx_urb)   usb_free_urb(catc->tx_urb);
-		if (catc->rx_urb)   usb_free_urb(catc->rx_urb);
-		if (catc->irq_urb)  usb_free_urb(catc->irq_urb);
+		if (catc->ctrl_urb)
+			usb_free_urb(catc->ctrl_urb);
+		if (catc->tx_urb)
+			usb_free_urb(catc->tx_urb);
+		if (catc->rx_urb)
+			usb_free_urb(catc->rx_urb);
+		if (catc->irq_urb)
+			usb_free_urb(catc->irq_urb);
 		kfree(netdev);
 		kfree(catc);
 		return -ENOMEM;
diff -puN drivers/usb/misc/auerswald.c~codingstyle-patrol-usb drivers/usb/misc/auerswald.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/misc/auerswald.c~codingstyle-patrol-usb	Sat May 10 21:24:57 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/misc/auerswald.c	Sat May 10 21:26:35 2003
@@ -572,7 +572,8 @@ static int auerchain_setup (pauerchain_t
         /* fill the list of free elements */
         for (;numElements; numElements--) {
                 acep = (pauerchainelement_t) kmalloc (sizeof (auerchainelement_t), GFP_KERNEL);
-                if (!acep) goto ac_fail;
+                if (!acep)
+			goto ac_fail;
 		memset (acep, 0, sizeof (auerchainelement_t));
                 INIT_LIST_HEAD (&acep->list);
                 list_add_tail (&acep->list, &acp->free_list);
@@ -780,16 +781,20 @@ static int auerbuf_setup (pauerbufctl_t 
         /* fill the list of free elements */
         for (;numElements; numElements--) {
                 bep = (pauerbuf_t) kmalloc (sizeof (auerbuf_t), GFP_KERNEL);
-                if (!bep) goto bl_fail;
+                if (!bep)
+			goto bl_fail;
 	        memset (bep, 0, sizeof (auerbuf_t));
                 bep->list = bcp;
                 INIT_LIST_HEAD (&bep->buff_list);
                 bep->bufp = (char *) kmalloc (bufsize, GFP_KERNEL);
-                if (!bep->bufp) goto bl_fail;
+                if (!bep->bufp)
+			goto bl_fail;
                 bep->dr = (struct usb_ctrlrequest *) kmalloc (sizeof (struct usb_ctrlrequest), GFP_KERNEL);
-                if (!bep->dr) goto bl_fail;
+                if (!bep->dr)
+			goto bl_fail;
                 bep->urbp = usb_alloc_urb (0, GFP_KERNEL);
-                if (!bep->urbp) goto bl_fail;
+                if (!bep->urbp)
+			goto bl_fail;
                 list_add_tail (&bep->buff_list, &bcp->free_buff_list);
         }
         return 0;
@@ -1242,7 +1247,8 @@ static void auerchar_ctrlread_dispatch (
 static void auerswald_delete( pauerswald_t cp)
 {
 	dbg( "auerswald_delete");
-	if (cp == NULL) return;
+	if (cp == NULL)
+		return;
 
 	/* Wake up all processes waiting for a buffer */
 	wake_up (&cp->bufferwait);
@@ -1261,7 +1267,8 @@ static void auerswald_delete( pauerswald
 static void auerchar_delete( pauerchar_t ccp)
 {
 	dbg ("auerchar_delete");
-	if (ccp == NULL) return;
+	if (ccp == NULL)
+		return;
 
         /* wake up pending synchronous reads */
 	ccp->removed = 1;
@@ -1335,7 +1342,8 @@ static void auerswald_removeservice (pau
 	dbg ("auerswald_removeservice called");
 
 	/* check if we have a service allocated */
-	if (scp->id == AUH_UNASSIGNED) return;
+	if (scp->id == AUH_UNASSIGNED)
+		return;
 
 	/* If there is a device: close the channel */
 	if (cp->usbdev) {
@@ -1494,7 +1502,8 @@ static int auerchar_ioctl (struct inode 
 		u = 0;	/* no data */
 		if (ccp->readbuf) {
 			int restlen = ccp->readbuf->len - ccp->readoffset;
-			if (restlen > 0) u = 1;
+			if (restlen > 0)
+				u = 1;
 		}
 		if (!u) {
         		if (!list_empty (&ccp->bufctl.rec_buff_list)) {
@@ -1787,7 +1796,8 @@ write_again:
 	}
 
 	/* protect against too big write requests */
-	if (len > cp->maxControlLength) len = cp->maxControlLength;
+	if (len > cp->maxControlLength)
+		len = cp->maxControlLength;
 
 	/* Fill the buffer */
 	if (copy_from_user ( bp->bufp+AUH_SIZE, buf, len)) {
@@ -2096,7 +2106,8 @@ static void auerswald_disconnect (struct
 		/* Inform all waiting readers */
 		for ( u = 0; u < AUH_TYPESIZE; u++) {
 			pauerscon_t scp = cp->services[u];
-			if (scp) scp->disconnect( scp);
+			if (scp)
+				scp->disconnect( scp);
 		}
 	}
 }
diff -puN drivers/usb/class/cdc-acm.c~codingstyle-patrol-usb drivers/usb/class/cdc-acm.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/class/cdc-acm.c~codingstyle-patrol-usb	Sat May 10 21:26:41 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/class/cdc-acm.c	Sat May 10 21:28:04 2003
@@ -252,7 +252,8 @@ static void acm_read_bulk(struct urb *ur
 	unsigned char *data = urb->transfer_buffer;
 	int i = 0;
 
-	if (!ACM_READY(acm)) return;
+	if (!ACM_READY(acm))
+		return;
 
 	if (urb->status)
 		dbg("nonzero read bulk status received: %d", urb->status);
@@ -286,7 +287,8 @@ static void acm_write_bulk(struct urb *u
 {
 	struct acm *acm = (struct acm *)urb->context;
 
-	if (!ACM_READY(acm)) return;
+	if (!ACM_READY(acm))
+		return;
 
 	if (urb->status)
 		dbg("nonzero write bulk status received: %d", urb->status);
@@ -299,7 +301,8 @@ static void acm_softint(void *private)
 	struct acm *acm = private;
 	struct tty_struct *tty = acm->tty;
 
-	if (!ACM_READY(acm)) return;
+	if (!ACM_READY(acm))
+		return;
 
 	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup)
 		(tty->ldisc.write_wakeup)(tty);
@@ -315,7 +318,8 @@ static int acm_tty_open(struct tty_struc
 {
 	struct acm *acm = acm_table[tty->index];
 
-	if (!acm || !acm->dev) return -EINVAL;
+	if (!acm || !acm->dev)
+		return -EINVAL;
 
 	tty->driver_data = acm;
 	acm->tty = tty;
@@ -350,7 +354,8 @@ static void acm_tty_close(struct tty_str
 {
 	struct acm *acm = tty->driver_data;
 
-	if (!acm || !acm->used) return;
+	if (!acm || !acm->used)
+		return;
 
 	if (!--acm->used) {
 		if (acm->dev) {
@@ -373,9 +378,12 @@ static int acm_tty_write(struct tty_stru
 {
 	struct acm *acm = tty->driver_data;
 
-	if (!ACM_READY(acm)) return -EINVAL;
-	if (acm->writeurb->status == -EINPROGRESS) return 0;
-	if (!count) return 0;
+	if (!ACM_READY(acm))
+		return -EINVAL;
+	if (acm->writeurb->status == -EINPROGRESS)
+		return 0;
+	if (!count)
+		return 0;
 
 	count = (count > acm->writesize) ? acm->writesize : count;
 
@@ -397,28 +405,32 @@ static int acm_tty_write(struct tty_stru
 static int acm_tty_write_room(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
-	if (!ACM_READY(acm)) return -EINVAL;
+	if (!ACM_READY(acm))
+		return -EINVAL;
 	return acm->writeurb->status == -EINPROGRESS ? 0 : acm->writesize;
 }
 
 static int acm_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
-	if (!ACM_READY(acm)) return -EINVAL;
+	if (!ACM_READY(acm))
+		return -EINVAL;
 	return acm->writeurb->status == -EINPROGRESS ? acm->writeurb->transfer_buffer_length : 0;
 }
 
 static void acm_tty_throttle(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
-	if (!ACM_READY(acm)) return;
+	if (!ACM_READY(acm))
+		return;
 	acm->throttle = 1;
 }
 
 static void acm_tty_unthrottle(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
-	if (!ACM_READY(acm)) return;
+	if (!ACM_READY(acm))
+		return;
 	acm->throttle = 0;
 	if (acm->readurb->status != -EINPROGRESS)
 		acm_read_bulk(acm->readurb, NULL);
@@ -427,7 +439,8 @@ static void acm_tty_unthrottle(struct tt
 static void acm_tty_break_ctl(struct tty_struct *tty, int state)
 {
 	struct acm *acm = tty->driver_data;
-	if (!ACM_READY(acm)) return;
+	if (!ACM_READY(acm))
+		return;
 	if (acm_send_break(acm, state ? 0xffff : 0))
 		dbg("send break failed");
 }
@@ -496,7 +509,8 @@ static void acm_tty_set_termios(struct t
 	struct acm_line newline;
 	int newctrl = acm->ctrlout;
 
-	if (!ACM_READY(acm)) return;
+	if (!ACM_READY(acm))
+		return;
 
 	newline.speed = cpu_to_le32p(acm_tty_speed +
 		(termios->c_cflag & CBAUD & ~CBAUDEX) + (termios->c_cflag & CBAUDEX ? 15 : 0));
diff -puN drivers/usb/class/usblp.c~codingstyle-patrol-usb drivers/usb/class/usblp.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/class/usblp.c~codingstyle-patrol-usb	Sat May 10 21:29:51 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/class/usblp.c	Sat May 10 21:30:54 2003
@@ -298,8 +298,10 @@ static int usblp_check_status(struct usb
 	status = *usblp->statusbuf;
 	if (~status & LP_PERRORP) {
 		newerr = 3;
-		if (status & LP_POUTPA) newerr = 1;
-		if (~status & LP_PSELECD) newerr = 2;
+		if (status & LP_POUTPA)
+			newerr = 1;
+		if (~status & LP_PSELECD)
+			newerr = 2;
 	}
 
 	if (newerr != err)
@@ -926,8 +928,8 @@ abort:
 		if (usblp->readbuf)
 			usb_buffer_free (usblp->dev, USBLP_BUF_SIZE,
 				usblp->readbuf, usblp->writeurb->transfer_dma);
-		if (usblp->statusbuf) kfree(usblp->statusbuf);
-		if (usblp->device_id_string) kfree(usblp->device_id_string);
+		kfree(usblp->statusbuf);
+		kfree(usblp->device_id_string);
 		usb_free_urb(usblp->writeurb);
 		usb_free_urb(usblp->readurb);
 		kfree(usblp);
@@ -987,10 +989,12 @@ static int usblp_select_alts(struct usbl
 				continue;
 
 			if (!(epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK)) {
-				if (!epwrite) epwrite=epd;
+				if (!epwrite)
+					epwrite = epd;
 
 			} else {
-				if (!epread) epread=epd;
+				if (!epread)
+					epread = epd;
 			}
 		}
 
@@ -1020,9 +1024,12 @@ static int usblp_select_alts(struct usbl
 		return proto_bias;
 
 	/* Ordering is important here. */
-	if (usblp->protocol[2].alt_setting != -1) return 2;
-	if (usblp->protocol[1].alt_setting != -1) return 1;
-	if (usblp->protocol[3].alt_setting != -1) return 3;
+	if (usblp->protocol[2].alt_setting != -1)
+		return 2;
+	if (usblp->protocol[1].alt_setting != -1)
+		return 1;
+	if (usblp->protocol[3].alt_setting != -1)
+		return 3;
 
 	/* If nothing is available, then don't bind to this device. */
 	return -1;
@@ -1036,7 +1043,8 @@ static int usblp_set_protocol(struct usb
 		return -EINVAL;
 
 	alts = usblp->protocol[protocol].alt_setting;
-	if (alts < 0) return -EINVAL;
+	if (alts < 0)
+		return -EINVAL;
 	r = usb_set_interface(usblp->dev, usblp->ifnum, alts);
 	if (r < 0) {
 		err("can't set desired altsetting %d on interface %d",
diff -puN drivers/usb/core/hcd-pci.c~codingstyle-patrol-usb drivers/usb/core/hcd-pci.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/core/hcd-pci.c~codingstyle-patrol-usb	Sat May 10 21:31:12 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/core/hcd-pci.c	Sat May 10 21:31:37 2003
@@ -209,7 +209,8 @@ void usb_hcd_pci_remove (struct pci_dev 
 		return;
 	dev_info (hcd->controller, "remove, state %x\n", hcd->state);
 
-	if (in_interrupt ()) BUG ();
+	if (in_interrupt ())
+		BUG ();
 
 	hub = hcd->self.root_hub;
 	hcd->state = USB_STATE_QUIESCING;
diff -puN drivers/usb/host/ohci-sa1111.c~codingstyle-patrol-usb drivers/usb/host/ohci-sa1111.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/host/ohci-sa1111.c~codingstyle-patrol-usb	Sat May 10 21:31:53 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/host/ohci-sa1111.c	Sat May 10 21:32:20 2003
@@ -209,7 +209,8 @@ int usb_hcd_sa1111_probe (const struct h
 
  err2:
 	hcd_buffer_destroy (hcd);
-	if (hcd) driver->hcd_free(hcd);
+	if (hcd)
+		driver->hcd_free(hcd);
  err1:
 	sa1111_stop_hc(dev);
 	release_mem_region(dev->res.start, dev->res.end - dev->res.start + 1);
@@ -237,7 +238,8 @@ void usb_hcd_sa1111_remove (struct usb_h
 
 	info ("remove: %s, state %x", hcd->self.bus_name, hcd->state);
 
-	if (in_interrupt ()) BUG ();
+	if (in_interrupt ())
+		BUG ();
 
 	hub = hcd->self.root_hub;
 	hcd->state = USB_STATE_QUIESCING;

_
