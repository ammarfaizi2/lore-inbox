Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279416AbRJ2T53>; Mon, 29 Oct 2001 14:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279421AbRJ2T5T>; Mon, 29 Oct 2001 14:57:19 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:55785 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S279416AbRJ2T5O>;
	Mon, 29 Oct 2001 14:57:14 -0500
Message-ID: <3BDDB4B3.2672CBDB@fc.hp.com>
Date: Mon, 29 Oct 2001 12:57:39 -0700
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: To SCSI driver maintainers: 16-byte CDB support in SCSI interface 
 drivers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ac series kernels starting with 2.4.10-ac5 contain a patch that enables
SCSI midlayer to send SCSI commands larger than 12 bytes to the
interface
drivers. Before sending a larger command, midlayer will check the
command size against Scsi_Host->max_cmd_len. If Scsi_Host->max_cmd_len
is larger than or equal to the command size, the command will be sent
to the interface driver else it will be terminated with an error.
scsi_register() sets Scsi_Host->max_cmd_len to 12 by default for every
interface. If a driver and the interface can support larger commands,
the driver should set Scsi_Host->max_cmd_len to the correct value after
calling scsi_register(). Please make this change to your driver if you
would like to support larger SCSI commands. Non-ac kernels will not
be affected by this change since Scsi_Host->max_cmd_len is unused on
those kernels.

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
