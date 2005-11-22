Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVKVV70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVKVV70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVKVV70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:59:26 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:37529 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1030187AbVKVV7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:59:22 -0500
Date: Tue, 22 Nov 2005 19:59:23 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm <akpm@osdl.org>, ehabkost@mandriva.com
Subject: [PATCH 0/2] - usbserial: Adds missing checks and bug fix.
Message-Id: <20051122195923.11daeedc.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Greg,

 I'm sending two patches for the usbserial NULL pointer dereference we
discussed last week:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113216151918308&w=2

 The first patch adds the missing checks you suggested we should use in
usb-serial driver's entry points, to avoid NULL pointer dereferences.

 The second one is the same I've sent before, except that now I'm using
down() in serial_close() instead of down_interruptible() (as you also
suggested). I didn't use down() in the first version because I don't
wanted processes in a close() waiting for a open() too long. But
Eduardo Habkost showed me it will not happen: the only possibility for a
open() to sleep after the semaphore was acquired, is when 'open_count'
equals 1, and there will be no close, since the port is being opened for the
first time.

 It's ok for a open() to wait a close().

 Both patches were tested with a pl2303 device, running hundreds of my
test-case and using minicom in parallel.

-- 
Luiz Fernando N. Capitulino
