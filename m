Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUISV6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUISV6v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUISV6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:58:50 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:21422 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264443AbUISV6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:58:45 -0400
Subject: Re: [PATCH] fix inlining trouble causing build failure in
	drivers/scsi/qla2xxx/qla_os.c
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0409192346490.2758@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0409192346490.2758@dragon.hygekrogen.localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Sep 2004 17:58:36 -0400
Message-Id: <1095631123.1717.20.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-19 at 17:58, Jesper Juhl wrote:
> 
> 2.6.9-rc2-bk5 allyesconfig fails to build for me with gcc 3.4.1 with the 
> following error : 

Actually, Adrian Bunk got there ahead of you.  The fix is in both the
scsi-misc-2.6 tree and 2.6.9-rc2-mm1

James

ChangeSet@1.2184, 2004-09-10 13:19:39-04:00, akpm@osdl.org
  [PATCH] qla2xxx gcc-3.5 fixes
  
  From: Adrian Bunk <bunk@fs.tum.de>
  
    CC      drivers/scsi/qla2xxx/qla_os.o
  drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_queuecommand':
  drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining
failed
  in call to 'qla2x00_callback': function not considered for inlining
  drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from
here
  drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining
failed
  in call to 'qla2x00_callback': function not considered for inlining
  drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from
here
  make[3]: *** [drivers/scsi/qla2xxx/qla_os.o] Error 1
  ...
    CC      drivers/scsi/qla2xxx/qla_rscn.o
  drivers/scsi/qla2xxx/qla_rscn.c: In function
`qla2x00_cancel_io_descriptors':
  drivers/scsi/qla2xxx/qla_rscn.c:320: sorry, unimplemented: inlining
  failed in call to 'qla2x00_remove_iodesc_timer': function not
considered for i
nlining
  drivers/scsi/qla2xxx/qla_rscn.c:257: sorry, unimplemented: called from
here
  make[3]: *** [drivers/scsi/qla2xxx/qla_rscn.o] Error 1
  
  Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>



