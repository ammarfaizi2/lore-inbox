Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267955AbUHPU7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267955AbUHPU7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUHPU7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:59:55 -0400
Received: from pop.gmx.net ([213.165.64.20]:45232 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267955AbUHPU7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:59:50 -0400
X-Authenticated: #1725425
Date: Mon, 16 Aug 2004 23:12:11 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jwendel10@comcast.net, linux-kernel@vger.kernel.org,
       Kai.Makisara@kolumbus.fi
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Message-Id: <20040816231211.76360eaa.Ballarin.Marc@gmx.de>
In-Reply-To: <1092661385.20528.25.camel@localhost.localdomain>
References: <411FD919.9030702@comcast.net>
	<20040816143817.0de30197.Ballarin.Marc@gmx.de>
	<1092661385.20528.25.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List of SCSI commands in cdrecord and k3b. Completeness and corectness are
not guaranteed and not even likely. Not all commands are actually used,
some are only for older hardware.

MODE_SELECT_* is not needed by cdrecord and fails gracefully as Kai
Makisara suspected. k3b seems broken, as it doesn't recognize devices as
writers if MODE_SELECT_10 fails (even when opening the device read-only).

Commands prepended by "->" are (probably) not mentioned in kernel include
files.

Now all that is left to do is determining which commands are safe and
fixing apps that only open devices read-only ;-)

0x00	TEST_UNIT_READY
0x01	REZERO_UNIT
0x03	REQUEST_SENSE
0x04	FORMAT_UNIT	k3b: declared, but not used
0x08	READ_6
0x0A	WRITE_6
0x0B	SEEK_6
-> 0x0D	/* qic02 Sysgen SC4000 */
0x12	INQUIRY / GPCMD_INQUIRY
0x15	MODE_SELECT
0x1A	MODE_SENSE
0x1B	GPCMD_START_STOP_UNIT
0x1E	GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL
0x23	GPCMD_READ_FORMAT_CAPACITIES
0x25	GPCMD_READ_CDVD_CAPACITY
0x28	GPCMD_READ_10
0x2A	GPCMD_WRITE_10
0x2B	GPCMD_SEEK
-> 0x2C	ERASE? k3b: declared, but not used
0x2E	GPCMD_WRITE_AND_VERIFY_10
0x2F	GPCMD_VERIFY_10
0x35	GPCMD_FLUSH_CACHE
0x3B	WRITE_BUFFER
0x3C	READ_BUFFER
0x42	GPCMD_READ_SUBCHANNEL
0x43	GPCMD_READ_TOC_PMA_ATIP
0x44	GPCMD_READ_HEADER
0x45	GPCMD_PLAY_AUDIO_10
0x46	GPCMD_GET_CONFIGURATION
0x47	GPCMD_PLAY_AUDIO_MSF
0x4A	GPCMD_GET_EVENT_STATUS_NOTIFICATION
0x4B	GPCMD_PAUSE_RESUME
0x4E	GPCMD_STOP_PLAY_SCAN
0x51	GPCMD_READ_DISC_INFO
0x52	GPCMD_READ_TRACK_RZONE_INFO
0x53	GPCMD_RESERVE_RZONE_TRACK
0x54	GPCMD_SEND_OPC
0x55	GPCMD_MODE_SELECT_10	k3b: needed even in read-only mode. Probably a bug.
0x58	GPCMD_REPAIR_RZONE_TRACK
-> 0x59	/* Read master cue */
0x5A	GPCMD_MODE_SENSE_10
0x5B	GPCMD_CLOSE_TRACK
-> 0x5C	/* Read buffer cap */
-> 0x5D	/* Send CUE sheet */	This is needed for DAO mode
0xA1	GPCMD_BLANK
0xA3	GPCMD_SEND_KEY
0xA4	GPCMD_REPORT_KEY
0xA5	MOVE_MEDIUM
0xA6	GPCMD_LOAD_UNLOAD
0xA7	GPCMD_SET_READ_AHEAD
0xA8	READ_12
0xAA	WRITE_12
0xAC	GPCMD_GET_PERFORMANCE
0xAD	GPCMD_READ_DVD_STRUCTURE
-> 0xB3	SC_SET_LIMITS
0xB6	GPCMD_SET_STREAMING
0xB9	GPCMD_READ_CD_MSF
0xBA	GPCMD_SCAN
0xBB	GPCMD_SET_SPEED
0xBD	GPCMD_MECHANISM_STATUS
0xBE	GPCMD_READ_CD
-> 0xBF
-> 0xC1
-> 0xC2	SC_SET_SUBCODE
-> 0xC3
-> 0xC4	SC_READ_PMA
-> 0xC5
-> 0xC6
-> 0xC7	SC_READ_DISK_INFO
-> 0xCE
-> 0xCF
-> 0xD4		/* Read audio command */
-> 0xD8		/* read audio command */
-> 0xDF
-> 0xE0	SC_BUFFER_INQUIRY
-> 0xE1	SC_WRITE_PMA
-> 0xE2
-> 0xE3	SC_FREEZE
-> 0xE4	SC_CLEAR_SUBCODE
-> 0xE5
-> 0xE6	SC_NEXT_WR_ADDRESS
-> 0xE7
-> 0xE9
-> 0xEB
-> 0xEC	SC_OPC_EXECUTE
-> 0xED
-> 0xEE	/* Read session info */
-> 0xEF	SC_READ_PEAK_BUF_CAP
-> 0xF0
-> 0xF1
-> 0xF2
-> 0xF3
-> 0xF5
-> 0xF6
-> 0xF8
