Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263270AbVCJWLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbVCJWLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVCJWHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:07:11 -0500
Received: from franklin.nevis.columbia.edu ([129.236.252.8]:29392 "EHLO
	franklin.nevis.columbia.edu") by vger.kernel.org with ESMTP
	id S263274AbVCJV6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:58:52 -0500
Date: Thu, 10 Mar 2005 16:58:51 -0500 (EST)
From: Felix Matathias <felix@nevis.columbia.edu>
To: linux-kernel@vger.kernel.org
Subject: select() doesn't respect SO_RCVLOWAT ?
Message-ID: <Pine.LNX.4.61.0503101645190.29442@shang.nevis.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear all,

I am running a 2.4.21-9.0.3.ELsmp #1 kernel and I can setsockopt and 
getsockopt correctly the SO_RCVLOWAT option, but select() seems to mark a 
socket readable even if a single byte is ready to be read. Then, a read() 
blocks until the specified number of bytes in SO_RCVLOWAT makes it to the 
socket buffer.

This is the exact opposite behaviour of what I yould have 
expected/desired. Our application receives data at many Khz rate and we 
want to avoid reading the socket until a predetermined amount of data is 
sent, to avoid partial reads. SO_RCVLOWAT seemed to be a nice way to 
implement that.

An earlier message by Alan Cox was a bit cryptic:

"But is the cost of all those special case checks and all the handling
for it such as select computing if enough tcp packets together accumulated
worth the cost on every app not using LOWAT for the microscopic gain given
that essentially nobody uses it."

Does this mean that select() in Linux will wake up no matter what 
SO_RCVLOWAT is set to ?

Best Regards,
Felix Matathias

P.S. I would appreciate if you could also cc your response to me.

-- 

______________________________________________________________________
Felix Matathias of Columbia University, Nevis Labs

Brookhaven National Lab           cell : 631-988-3694
Bldg 1005, 3-304                  web  : http://www.matathias.com
Upton, NY, 11973                  photo: http://www.pbase.com/matathias
tel/fax :631-344-7622/3253        email: felix@nevis.columbia.edu
_______________________________________________________________________

