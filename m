Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSJPVoE>; Wed, 16 Oct 2002 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbSJPVnS>; Wed, 16 Oct 2002 17:43:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60671 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261441AbSJPVnG>; Wed, 16 Oct 2002 17:43:06 -0400
Importance: Normal
Sensitivity: 
Subject: Re: CIFS find_tcp_session/GlobalSMBSessionList protection
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF464594F1.0BE8F6E7-ON87256C54.0076D48A@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Wed, 16 Oct 2002 16:47:08 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/16/2002 03:47:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zwane,
So far your fixes have tested out ok.   I have made minor additions - e.g.
to move a similar null pointer check (on the private area of the sb)
earlier in umount as well.   On the protection of the GlobalSMBSession and
TreeConnection lists, I changed it in my testing to a rwlock_t rather than
a rw_sem since I think we can ensure that it never need be held across any
blocking calls.   I will package these in a bitkeeper change set later this
evening and submit them.   I have not added in your change to
ipv4_reconnect yet since there are other areas where that particular code
path needs work and I would like to submit the improvements for
reconnection after network failure in one piece.

Thanks for spotting these.

The CIFS VFS seems to be doing ok on the file API stress testing I have
tried so far, but these should help as I do more testing on MP hardware.



Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


