Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUDAPlw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUDAPlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:41:52 -0500
Received: from shuttle.eclipse.ncsc.mil ([144.51.102.80]:54413 "EHLO
	eclipse.ncsc.mil") by vger.kernel.org with ESMTP id S262673AbUDAPlt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:41:49 -0500
From: "Robert W. Maloy" <r.w.maloy@acm.org>
Reply-To: r.w.maloy@acm.org
Organization: I331 (C41)
To: linux-kernel@vger.kernel.org
Subject: Possible error in fs/buffer.c
Date: Thu, 1 Apr 2004 10:43:49 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404011043.49077.r.w.maloy@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	While code surfing I found what appears to be a problem with the 
following code in fs/buffer.c {function mark_buffer_inode_dirty}: 

       if (list_empty(&bh->b_assoc_buffers))
                buffer_insert_list(&buffer_mapping->private_lock,
                                bh, &mapping->private_list);

	From my research, the job of buffer_insert_list is to place the list 
contents of bh->b_assoc_buffers onto the list mapping->private list. 
The above code segment will only call buffer_insert_list if 
b_assoc_buffers is empty. Why waste the time, and resources 
attempting to add an empty list to the end of private_list?

	If this is a problem, then there are two possibilities for fixing 
this code: 

    1) This was just a mistake
	add "!" in the if, this only adds the list if there is 
        something to add.
		- if (list_empty(&bh->b_assoc_buffers))
		+ if (!list_empty(&bh->b_assoc_buffers))

    2) Some of the assoc buffers may already be on the private_list. 
If this is a possibility then this routine will need more work.
	


Please CC me on all responses since I am not a member of this list.

-- 
Cheers
Rob Maloy
r.w.maloy@acm.org
(410) 854-6637
