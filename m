Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270466AbRHHMA7>; Wed, 8 Aug 2001 08:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270464AbRHHMAw>; Wed, 8 Aug 2001 08:00:52 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:53004 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S270466AbRHHMAl>;
	Wed, 8 Aug 2001 08:00:41 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Urban Widmark <urban@teststation.com>
Date: Wed, 8 Aug 2001 14:00:10 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: netfs allows multiple identical mounts (was: smb/mount 
CC: <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@fys.uio.no>, pdan@spiral.extreme.ro
X-mailer: Pegasus Mail v3.40
Message-ID: <32C99E30BA@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Aug 01 at 1:20, Urban Widmark wrote:
> On Mon, 6 Aug 2001, Dan Podeanu wrote:
> > This should be self explanatory. My guess is, its probably the smb
> > filesystem reporting as mounting again a share after network failure.
> 
> A very simple way to reproduce this (on 2.4.7):
> 
> $ mount -t smbfs -o username=puw //srv/share /mnt/smb
> $ mount -t smbfs -o username=puw //srv/share /mnt/smb
> $ cat /proc/mounts | grep smbfs
> //srv/share /mnt/smb smbfs rw 0 0
> //srv/share /mnt/smb smbfs rw 0 0
> 
> This is probably something that smbmount could check before mounting.
> But I'm not sure if that is the best fix.

For sure it is, as doing

mount -t smbfs -o username=a //srv/share /mnt/smb
mount -t smbfs -o username=b //srv/share /mnt/smb

looks quite legal to me, as both //srv/share can display completely
different set of files, and nobody except smbfs knows that username=a/
username=b matters, but fmode=700/fmode=755 does not...
 
> It could compare the server string ("//srv/share") but what if that server
> listens to more than one name?

ncpfs (mount.ncp) will warn you if //srv/share is listed anywhere in
/etc/mtab and it is mounted by you. If you'll use '-o multiple', then
it is assumed that you know what you are doing, and nothing prevents you
from mounting same thing on same place 255 times.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
