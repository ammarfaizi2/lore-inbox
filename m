Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264515AbUEDQzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUEDQzC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbUEDQzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:55:02 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:18092 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264517AbUEDQy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:54:59 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Tue, 4 May 2004 18:54:54 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Accessing sysenter page by kernel syscalls
X-mailer: Pegasus Mail v3.50
Message-ID: <5737E6105A3@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  is there any reason why copy_from_user does not punch hole in
kernel space to get it possible to access sysenter page? I do not think
that it would add too big overhead to copy_*_user (which is already long),
but I cannot think about any other reason why sysenter page is not
accessible through write().

  Today I wanted to confirm whether my kernel uses sysenter or int 0x80, 
and I found that simple program below does not work and I had to copy page 
first to some temporary location, and then write it from this temporary 
location to stdout.
  
void main(void) {
  write(1, (void*)0xFFFFE000, 4096);
}
                                                    Thanks,
                                                        Petr Vandrovec
                                                

