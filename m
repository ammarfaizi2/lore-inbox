Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWAYA1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWAYA1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWAYA1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:27:48 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:22672 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750915AbWAYA1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:27:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=qwP43f9UnYcbgqUg+o9FmiBr7MIzzeUaNrLprV5TuRQVWRUoCcy2jR3iwW2GyyH6o32hXzrYuY18jd6HTvA6yg9ggruUPOBXN7t/hKFbal7xYrMMCDQuvJf2KV9hb+cX5KFzsQ1+JW43a7XwyPqPyy5W0jCzDBrFdxqIQaPbBVM=
Date: Wed, 25 Jan 2006 03:45:30 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ixj: fix writing silence check
Message-ID: <20060125004530.GF3234@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

j->write_buffer_rp is a pointer.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/telephony/ixj.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/telephony/ixj.c
+++ b/drivers/telephony/ixj.c
@@ -3558,10 +3558,16 @@ static void ixj_write_frame(IXJ *j)
 				}
 			/* Add word 0 to G.729 frames for the 8021.  Right now we don't do VAD/CNG  */
 				if (j->play_codec == G729 && (cnt == 0 || cnt == 10 || cnt == 20)) {
-					if(j->write_buffer_rp + cnt == 0 && j->write_buffer_rp + cnt + 1 == 0 && j->write_buffer_rp + cnt + 2 == 0 &&
-					   j->write_buffer_rp + cnt + 3 == 0 && j->write_buffer_rp + cnt + 4 == 0 && j->write_buffer_rp + cnt + 5 == 0 &&
-					   j->write_buffer_rp + cnt + 6 == 0 && j->write_buffer_rp + cnt + 7 == 0 && j->write_buffer_rp + cnt + 8 == 0 &&
-					   j->write_buffer_rp + cnt + 9 == 0) {
+					if (j->write_buffer_rp[cnt] == 0 &&
+					    j->write_buffer_rp[cnt + 1] == 0 &&
+					    j->write_buffer_rp[cnt + 2] == 0 &&
+					    j->write_buffer_rp[cnt + 3] == 0 &&
+					    j->write_buffer_rp[cnt + 4] == 0 &&
+					    j->write_buffer_rp[cnt + 5] == 0 &&
+					    j->write_buffer_rp[cnt + 6] == 0 &&
+					    j->write_buffer_rp[cnt + 7] == 0 &&
+					    j->write_buffer_rp[cnt + 8] == 0 &&
+					    j->write_buffer_rp[cnt + 9] == 0) {
 					/* someone is trying to write silence lets make this a type 0 frame. */
 						outb_p(0x00, j->DSPbase + 0x0C);
 						outb_p(0x00, j->DSPbase + 0x0D);

