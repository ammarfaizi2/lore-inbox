Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTDMMm5 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTDMMm5 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:42:57 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:40355 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263488AbTDMMm4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 08:42:56 -0400
Message-ID: <20030413125438.71422.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Nirmala S" <nmala@mail.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 13 Apr 2003 07:54:37 -0500
Subject: Clustering of Request in block layer
X-Originating-Ip: 203.124.128.117
X-Originating-Server: ws1-11.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As per my understanding the block layer clusters requests for all
block drivers.
Clustering -
Creating a linked list of buffer_heads using b_reqnext.

But, when I run my block driver and try to view the number of
clustered requests in my Request function, I do not find any
clustering done.

void own_request(request_queue_t *q)
{
    struct buffer_head *tmp;
    int count;
    while(1) {
        INIT_REQUEST;
        printk("<1>request %p: cmd %i sec %li (nr. %li)\n", CURRENT,
               CURRENT->cmd,
               CURRENT->sector,
               CURRENT->current_nr_sectors);
       count=0;
       for (tmp=bh; tmp; tmp=tmp->b_reqnext)
            count ++;
       printk("Count = %d\n", count);
        end_request(1); /* success */
    }
}

The above always shows 'Count = 1'. dd if=/dev/mydevice of=/dev/null.
Does this mean that no clustering is done ??

Just read a document a "http://www.usenix.org/publications/library/proceedings/usenix2000/freenix/full_papers/gopinath/gopinath_html/node14.html" 
which says "This clustering is performed only for the drivers compiled in the kernel and not for loadable modules."

Is this the reason ??

Regards,
Mala

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

