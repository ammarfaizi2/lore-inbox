Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVKVV7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVKVV7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVKVV7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:59:50 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:44441 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1030189AbVKVV7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:59:42 -0500
Date: Tue, 22 Nov 2005 19:59:47 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm@osdl.org, ehabkost@mandriva.com
Subject: [PATCH 1/2] - usbserial: Adds missing parameters checks.
Message-Id: <20051122195947.4d910ccd.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Checks if 'port' is NULL before using it in all tty operations, this
can avoid NULL pointer dereferences.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/usb-serial.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -188,6 +188,8 @@ static int serial_open (struct tty_struc
 
 	portNumber = tty->index - serial->minor;
 	port = serial->port[portNumber];
+	if (!port)
+		return -ENODEV;
 	 
 	++port->open_count;
 
@@ -258,6 +260,9 @@ static int serial_write (struct tty_stru
 	struct usb_serial_port *port = tty->driver_data;
 	int retval = -EINVAL;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d, %d byte(s)", __FUNCTION__, port->number, count);
 
 	if (!port->open_count) {
@@ -277,6 +282,9 @@ static int serial_write_room (struct tty
 	struct usb_serial_port *port = tty->driver_data;
 	int retval = -EINVAL;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -296,6 +304,9 @@ static int serial_chars_in_buffer (struc
 	struct usb_serial_port *port = tty->driver_data;
 	int retval = -EINVAL;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s = port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -314,6 +325,9 @@ static void serial_throttle (struct tty_
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		return;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -330,6 +344,9 @@ static void serial_unthrottle (struct tt
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		return;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -347,6 +364,9 @@ static int serial_ioctl (struct tty_stru
 	struct usb_serial_port *port = tty->driver_data;
 	int retval = -ENODEV;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d, cmd 0x%.4x", __FUNCTION__, port->number, cmd);
 
 	if (!port->open_count) {
@@ -368,6 +388,9 @@ static void serial_set_termios (struct t
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		return;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -384,6 +407,9 @@ static void serial_break (struct tty_str
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		return;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -445,6 +471,9 @@ static int serial_tiocmget (struct tty_s
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -464,6 +493,9 @@ static int serial_tiocmset (struct tty_s
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {


-- 
Luiz Fernando N. Capitulino
