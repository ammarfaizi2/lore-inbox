Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSKTQvJ>; Wed, 20 Nov 2002 11:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSKTQvJ>; Wed, 20 Nov 2002 11:51:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:52410 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261456AbSKTQvI>; Wed, 20 Nov 2002 11:51:08 -0500
Importance: Low
Sensitivity: 
Subject: [CHECKER] 16 more potential buffer overruns in 2.5.48
To: acc@CS.Stanford.EDU, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFF1AA16C4.904AD55A-ON87256C77.00529B26@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Wed, 20 Nov 2002 10:56:12 -0600
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 6.0 [IBM]|November 8, 2002) at
 11/20/2002 09:56:54
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

In the four fs/cifs/smbdes.c (which is based on a similar password hash in
Samba) hits from your tool the code is a little strange looking but does
not have a buffer overrun.  Apparently the tool is not checking the maximum
size of the index since although the s_box array is only 256 bytes in size,
the array index is an unsigned char and can not go beyond 255 and overrun
the array.  As long as unsigned char can never go above 255 the code should
work.   It might have be more readable if it were defined as a  __u8
instead of an unsigned char.

Thanks.

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com

