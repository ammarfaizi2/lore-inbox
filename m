Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132906AbRDJDOu>; Mon, 9 Apr 2001 23:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132907AbRDJDOj>; Mon, 9 Apr 2001 23:14:39 -0400
Received: from rmx614-mta.mail.com ([165.251.48.52]:12466 "EHLO
	rmx614-mta.mail.com") by vger.kernel.org with ESMTP
	id <S132906AbRDJDOg>; Mon, 9 Apr 2001 23:14:36 -0400
From: e-double@iname.com
MIME-Version: 1.0
Message-Id: <0104092314299F.00428@weba8.iname.net>
Date: Mon, 9 Apr 2001 23:14:29 -0400 (EDT)
Content-Type: Text/Plain
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: eweinstein@cya.com
Subject: AIC7XXX oddities
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
I've been using the new aic7xxx driver, and updating frequently from Justin's site.  I'm at v6.1.11 now with kernel 2.4.3 and still experiencing some odd behaviour.  For example, I start as such on BUS 0 (an aic-29160):
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 5 Lun 0 Settings
                Commands Queued 13199
                Commands Active 0
                Command Openings 49
                Max Tagged Openings 253
                Device Queue Frozen Count 0
After an invocation of cdrecord --scanbus
dmesg reveals this on BUS1 (an aha-2940u2w):
(scsi1:A:1): 5.000MB/s transfers (5.000MHz, offset 15)
(scsi1:A:6): 20.000MB/s transfers (20.000MHz, offset 15)
(locating burner at 6, and zip at 5)

An invocation of hdparm -Tt /dev/sda (id 5) does this:

(scsi1:A:1): 5.000MB/s transfers (5.000MHz, offset 15)
(scsi1:A:6): 20.000MB/s transfers (20.000MHz, offset 15)
(scsi0:A:5): 3.300MB/s transfers

cat /proc/scsi/aic7xxx/0 :
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 3.300MB/s transfers
        Curr: 3.300MB/s transfers
        Channel A Target 5 Lun 0 Settings
                Commands Queued 16817
                Commands Active 0
                Command Openings 49
                Max Tagged Openings 253
                Device Queue Frozen Count 0

Target 5 has dropped to 3.300MB/s ??

thanks,

Ethan W.


---------------------------------------------------
Get free personalized email at http://www.iname.com
