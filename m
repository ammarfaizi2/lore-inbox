Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291172AbSBGSQS>; Thu, 7 Feb 2002 13:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291179AbSBGSQJ>; Thu, 7 Feb 2002 13:16:09 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:13074 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S291172AbSBGSPv>;
	Thu, 7 Feb 2002 13:15:51 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Patrick Mochel <mochel@osdl.org>
Date: Thu, 7 Feb 2002 19:15:24 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] read() from driverfs files can read more bytes 
CC: <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <1124DDDD7FF9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Feb 02 at 9:43, Patrick Mochel wrote:
> > And neither of driverfs_read_file nor driverfs_write_file supports
> > semantic we use with other filesystems: If at least one byte was 
> > read/written, return byte count (even if error happens). Only if zero 
> > bytes was written, return error code.
> 
> I would think that you would want to return the error code. Say you did:
> 
> echo "action parameter" > file
> 
> and 'parameter' is an invalid parameter, as determined by the driver. It 
> would require another arbitrary check to determine if the command 
> succeeded or not if it returned the number of bytes written. Returning 
> -EINVAL lets userspace know that it made a boo-boo. Is that not good?

If you want bidirectional communication, something like SOCK_SEQPACKET
or SOCK_DGRAM is better suitable. And if we learn open() to open
unix sockets, even 'echo' can be still used for configuring. I understand 
that it is radical change, but why these configuration points should
look like real files if they are not ones? And you do not have troubles
with supporting lseek() on them - if contents of file is "minutes\n",
is it correct to do lseek(fd, 1, SEEK_SET); write(fd, "onths\n", 6);
or is it incorrect usage?

If you do not want to change these objects from files to sockets,
I agree with your explanation for write(). But I do not agree with this
semantic for read() - reading byte after byte, and reading in one big 
chunk should not yield in different results on regular files, otherwise 
couple of nasty surprises is hidding there.
                                    Thanks,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
