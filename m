Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbTGBW1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264679AbTGBW1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:27:20 -0400
Received: from titan.PLASMA.Xg8.DE ([212.227.110.100]:53259 "EHLO
	titan.PLASMA.Xg8.DE") by vger.kernel.org with ESMTP id S264670AbTGBW1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:27:18 -0400
From: Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Organization: PLASMA
To: linux-kernel@vger.kernel.org
Date: Thu, 03 Jul 2003 00:41:21 +0200
MIME-Version: 1.0
Subject: Behaviour of access(x, X_OK) in 2.2 vs. 2.4
Reply-to: rtc@helen.PLASMA.Xg8.DE, linux-kernel@vger.kernel.org
Message-ID: <3F037BB1.9318.32D79C1@localhost>
X-mailer: Pegasus Mail for Windows (v4.11)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm still using linux 2.2 and I noticed today that the behaviour of 
the access() system call concerning the execution permission (X_OK), 
if invoked by uid 0, has been changed in 2.4.  In 2.4 it seems to 
take the execute permission bit into account while in 2.2, for uid 0, 
it returns success (0) independent from it, although execve fails if 
invoked on a file without x bit.  The difference can be demonstrated 
quite easily using the bash builtin test command on a file without x 
bit, which (like /usr/bin/access from tetex and unlike /usr/bin/test 
from sh-utils) seems to use access(): 

On 2.2: 
bash# cd /tmp && touch xx && test -x xx && echo x || echo y
x

although

bash# cd /tmp && cp /bin/echo . && chmod 0 echo && ./echo
bash: ./echo: Permission denied

On 2.4:
bash# cd /tmp && touch xx && test -x xx && echo x || echo y
y

(Note this assumes an umask of 0022.)

I searched the web, newsgroups and mailing list archives about this 
problem, to no avail.  Is there some backport, workaround or patch 
for 2.2 to get the same (and obsiously more sane) behaviour as in 
2.4?

Please make sure you CC me if you reply as I'm not subscribed. 
-- Peter 'Rattacresh' Backes, rtc@helen.PLASMA.Xg8.DE

