Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263032AbREaQPf>; Thu, 31 May 2001 12:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbREaQPZ>; Thu, 31 May 2001 12:15:25 -0400
Received: from motgate.mot.com ([129.188.136.100]:39835 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id <S263034AbREaQPN>;
	Thu, 31 May 2001 12:15:13 -0400
Message-Id: <3B166DD1.94BF4B44@crm.mot.com>
Date: Thu, 31 May 2001 18:14:09 +0200
From: Emmanuel Varagnat <varagnat@crm.mot.com>
Organization: Motorola
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Sysctl problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I registered a new directory and its tree in the proc filesystem with
some register_sysctl_table. And naturally I use unregister_sysctl_table
when the module is unloaded.
And everything seems to work fine.

Execpt that I can't read the corresponding data with the 'cat' command.
A 'strace'
shows me that 'cat' is in a loop :
...
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
1024) = 1024
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
1024) = 1024
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
1024) = 1024
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
1024) = 1024
...

I'm using my own function to change the data value, but helped by
proc_dointvec.
My function doesn't seem to be called.

Does anybody ever met something like this ?

Thanks

-Manu
