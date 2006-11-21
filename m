Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030879AbWKULeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030879AbWKULeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030881AbWKULeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:34:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:13103 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030879AbWKULeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:34:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Yf5iUIPl9CGOLaWpaWr9Akx+y4RH92hyUq5t6kyOW5bJBfXyVoXKJ0OrUfFPeNLBKCPxWCcP3FMHua3OetRN3CTGj5kkHe+NOtcf55RE6ARSjfZ+Kdxf/Ik3uAi8c/YNwivqt7M2vPaanvGgx10S6reH5XKqDN8o63nKcxYGjto=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][0/2] NFS: Calculate 'w' a bit later in *_encode_getaclres()
Date: Tue, 21 Nov 2006 12:33:59 +0100
User-Agent: KMail/1.9.5
Cc: Andreas Gruenbacher <agruen@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, David Rientjes <rientjes@cs.washington.edu>,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211234.00251.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two patches that implement a tiny performance improvement for NFS.

The change made is to calculate the value of the 'w' variable a little 
later than is currently done. This way we don't waste time calculating 'w' 
in the cases where we return from the function before using the calculated 
value.  It also saves a few bytes of .text, which is always nice.

The last time around these got merged in -mm and subsequently dropped - 
according to akpm, they got dropped due to maintainer NACK, but my 
impression was that this change was OK.  So, this time around It would be 
great with an explicit ACK or NACK so akpm can add the patches or ignore 
them.

The two patches are send with the following subjects to the same recipients
as this mail:

  [PATCH][1/2] NFS2: Calculate 'w' a bit later in nfsaclsvc_encode_getaclres()
  [PATCH][2/2] NFS3: Calculate 'w' a bit later in nfs3svc_encode_getaclres()


Kind regards,

  Jesper Juhl <jesper.juhl@gmail.com>

