Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281468AbRKVIxz>; Thu, 22 Nov 2001 03:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRKVIxp>; Thu, 22 Nov 2001 03:53:45 -0500
Received: from firewall.esrf.fr ([193.49.43.1]:17287 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S281468AbRKVIxZ>;
	Thu, 22 Nov 2001 03:53:25 -0500
Date: Thu, 22 Nov 2001 09:52:51 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: linux-kernel@vger.kernel.org
Subject: NFS problem
Message-ID: <20011122095251.A18254@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
        I have a QFS filesystem on a solaris 8 which is exported via
NFS:
qfs1                 2848604160 3996672 2844607488     1%
/data/id19/inhouse

([3] % uname -a 
SunOS azure 5.8 Generic_108528-09 sun4u sparc SUNW,Ultra-4 )

The QFS have an option on it's directories: you can change the attributes
on a directory with setfa (set file atrributes) to direct IO or page
cache.
Here is the concerned excerpt of the QFS setfa manpage:
"
     -D   Specifies the direct I/O attribute be permanently set
          for this file.  This means data is transferred directly
          between the user's buffer and disk.  This attribute
          should only be set for large block aligned sequential
          I/O.  The default I/O mode is buffered (uses the page
          cache).  Directio will not be used if the file is
          currently memory mapped.  See man directio(3C) for
          Solaris 2.6 and above for more details, however the
          SAM-FS directio attribute is permanent.
"
With this option we have strange performences:
>From a solaris client to this solaris server we have approximatively
40MB/s, with a linux client >1MB/s. Without directio mode we have
approximatively 20MB/s on a linux and 20MB/s on a solaris
( I have tested on several solaris clients, several linux client with
gigabit ethernet links and without (for having 20MB/s) ).

I thought that NFS's underlying FS do not have any effect on NFS
performances, and that the client is not aware of the ("local") remote
FS. 
Am I wrong ? 
Does anybody have an idea to fix the problem ? 
Is it a bug in NFS's implementation of linux kernel ?

Thanks in advance
        Sam
