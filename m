Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263032AbSJBKLC>; Wed, 2 Oct 2002 06:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263033AbSJBKLC>; Wed, 2 Oct 2002 06:11:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9482 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263032AbSJBKLA>; Wed, 2 Oct 2002 06:11:00 -0400
Date: Wed, 2 Oct 2002 11:16:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Dereferencing semaphores and atomic_t's
Message-ID: <20021002111625.B24770@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/scsi_error.c:

        SCSI_LOG_ERROR_RECOVERY(3, printk("Wake up parent %d\n",
                                          shost->eh_notify->count.counter));

        up(shost->eh_notify);

drivers/scsi/hosts.c:

                up(shost->eh_wait);
                SCSI_LOG_ERROR_RECOVERY(5, printk("Waking error handler"
                                          "thread (%d)\n",
                                          atomic_read(&shost->eh_wait->count)));


                up(shost->eh_wait);
                SCSI_LOG_ERROR_RECOVERY(5, printk("Waking error handler"
                                          "thread (%d)\n",
                                          atomic_read(&shost->eh_wait->count)));

Do we really allow this type of layering violation?

(There appear to be some circumstances when obtaining the semaphore count is
useful, but shouldn't we provide an architecture helper function to do that
since a semaphore structure _is_ an architecture-defined opaque structure.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

