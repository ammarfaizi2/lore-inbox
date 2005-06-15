Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFOOyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFOOyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVFOOyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:54:51 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:33664 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261151AbVFOOyl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:54:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LTfuThAUCoJP1uBmVto6O9twW9OTJa3mjCAojR3E28hM4FG7t2CYCJSAc4ZawBjv3psAcsD3fABf0EtAdAV4cRKtkyC5qzvW8dtskXylQ1hKnabBLDa6R1vjzaKiXyZ7Q0rLjGB9/BqOzcinppugY+VgiBthZM0KV2sqO2cPAW8=
Message-ID: <230a243e050615075472e8309c@mail.gmail.com>
Date: Wed, 15 Jun 2005 16:54:38 +0200
From: Alexander Sandler <alexander.sandler@gmail.com>
Reply-To: Alexander Sandler <alexander.sandler@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Weirdness in error handling in SCSI and block layers.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list.

I recently noticed something wrong in error handling in between SCSI
and block device driver layers.

The problem is that SCSI errors are not actually passed to block
device layer. When scsi_end_request() calls end_that_request_chunk()
it passes only the uptodate value which set earlier, at the end of
scsi_io_completion(), and only indicate whether request succeeded or
failed. Eventually __end_that_request_first() calls bio_endio() with
either -EIO or uptodate value (that in case of success will be 0). As
a result, instead of getting error code that more or less indicates
what kind of error took place, block device layer always gets -EIO.

Any comments/ideas?

Alexander Sandler.

PS: Please CC to me.
