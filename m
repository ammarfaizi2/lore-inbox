Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVAHKnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVAHKnm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVAHHuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:50:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:49029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261874AbVAHFsT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:19 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632601397@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:41 -0800
Message-Id: <11051632612059@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.17, 2004/12/21 10:01:15-08:00, greg@kroah.com

USB: explicitly mark the endianness of some visor data fields.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/serial/visor.c |    4 +---
 drivers/usb/serial/visor.h |    6 +++---
 2 files changed, 4 insertions(+), 6 deletions(-)


diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	2005-01-07 15:41:55 -08:00
+++ b/drivers/usb/serial/visor.c	2005-01-07 15:41:55 -08:00
@@ -734,9 +734,7 @@
 	if (retval == sizeof(*connection_info)) {
 	        connection_info = (struct visor_connection_info *)transfer_buffer;
 
-		le16_to_cpus(&connection_info->num_ports);
-		num_ports = connection_info->num_ports;
-
+		num_ports = le16_to_cpu(connection_info->num_ports);
 		for (i = 0; i < num_ports; ++i) {
 			switch (connection_info->connections[i].port_function_id) {
 				case VISOR_FUNCTION_GENERIC:
diff -Nru a/drivers/usb/serial/visor.h b/drivers/usb/serial/visor.h
--- a/drivers/usb/serial/visor.h	2005-01-07 15:41:55 -08:00
+++ b/drivers/usb/serial/visor.h	2005-01-07 15:41:55 -08:00
@@ -89,7 +89,7 @@
  * VISOR_GET_CONNECTION_INFORMATION returns data in the following format
  ****************************************************************************/
 struct visor_connection_info {
-	__u16	num_ports;
+	__le16	num_ports;
 	struct {
 		__u8	port_function_id;
 		__u8	port;
@@ -135,12 +135,12 @@
 struct palm_ext_connection_info {
 	__u8 num_ports;		
 	__u8 endpoint_numbers_different;
-	__u16 reserved1;
+	__le16 reserved1;
 	struct {
 		__u32 port_function_id;
 		__u8 port;
 		__u8 end_point_info;
-		__u16 reserved;
+		__le16 reserved;
 	} connections[2];
 };
 

