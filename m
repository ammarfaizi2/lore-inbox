Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266957AbSKLWcC>; Tue, 12 Nov 2002 17:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbSKLWcB>; Tue, 12 Nov 2002 17:32:01 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:53259 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S266957AbSKLWb7>; Tue, 12 Nov 2002 17:31:59 -0500
To: linux-kernel@vger.kernel.org
Subject: pci_unregister_driver() problem?
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 13 Nov 2002 07:38:43 +0900
Message-ID: <87el9ql8gc.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm playing the pcmcia of 2.5.47 on my new machine. And, I got the
Oops after yenta_socket.o was unloaded. It seems pci_unregister_driver()
doesn't call pci_driver->remove().  So, pcmcia driver couldn't release
the resouce.

This reproduce it,

    # modprobe yenta_socket
    # modprobe -r yenta_socket
    ... happen the interrupt, because it was shared irq
    Oops

I think driver-model(?) expects using dev->release(), in this
case. Corrent?  And, How should it fix?

Regards
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
