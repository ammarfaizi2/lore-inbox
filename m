Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUAMGvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 01:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbUAMGvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 01:51:24 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:20098 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263726AbUAMGvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 01:51:22 -0500
Date: Mon, 12 Jan 2004 22:51:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: kernel@cnspc18.murdoch.edu.au
Subject: [Bug 1853] New: smbfs reconnect does not quite work	properly
Message-ID: <901260000.1073976670@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1853

           Summary: smbfs reconnect does not quite work properly
    Kernel Version: 2.6.1-rc3
            Status: NEW
          Severity: normal
             Owner: fs_samba-smb@kernel-bugs.osdl.org
         Submitter: kernel@cnspc18.murdoch.edu.au


Distribution: Debian testing/unstable 
Hardware Environment: PIII/450 
Software Environment:  
Problem Description: 
smbfs mount reconnection due to inactivity timeout should not pass failure 
back to userspace 
 
Steps to reproduce: 
* Mount remote smbfs drive (eg. from a Win98 or W2K box). 
* Wait for it to time out (eg. by not accessing it for a couple of hours). 
* Access the drive. 
    Under 2.4.x I would have seen message such as: 
      Jan 10 06:25:48 wibble kernel: smb_get_length: recv error = 5 
      Jan 10 06:25:48 wibble kernel: smb_request: result -5, setting invalid 
      Jan 10 06:25:48 wibble kernel: smb_retry: successful, new pid=31576, 
generation=43 
    The connection would immediately get reestablished and userspace would be 
none the wiser that anything went wrong. 
    Under 2.6.1-rc3 however: 
      Jan 12 02:01:28 wibble kernel: SMB connection re-established (-5) 
      Jan 12 02:01:28 wibble kernel: smb_lookup: find //Program Files failed, 
error=-57 
      And userspace would see an error: 
      find: /mnt/blue: Invalid slot 
    Subsequent accesses to the drive work fine. It would be infinitely 
preferable for the error not reach userspace.


