Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272703AbRIGPEP>; Fri, 7 Sep 2001 11:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272702AbRIGPEF>; Fri, 7 Sep 2001 11:04:05 -0400
Received: from mx2.port.ru ([194.67.57.12]:55818 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S272701AbRIGPEA>;
	Fri, 7 Sep 2001 11:04:00 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109071926.f87JQ9l06082@vegae.deep.net>
Subject: Recent kernels sound crash  solution found?
To: alan@lxorguk.ukuu.org.uk
Date: Fri, 7 Sep 2001 19:26:08 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         Hello folks, seems that i found the potential bug which
    led to the infinite trace i`ve described before.

   Facts:
       1. My host have 24M of RAM and on kernels 2.4.x;x>7 it  started
   to have n-order alloc failures.
       2. In very rare circumsistances under 2.4.8-ac12 i have
   1-order alloc failures.
       3. sound_alloc_dmap::dmabuf.c comments states it will loop
   until the buffer is alloced
       4. sound_alloc_dmap::dmabuf.c comments states it wont accept buffer
   lesser than 8k in size.

   Logic:
      3 + 4 => it loops forever when 1-order alloc fails
      1 + 2 + 3 + 4 => my host crashes

      * comment to point 2: very rare circumcistances includes
   that some time should pass to fragment memory

cheers, Sam 
