Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbTANPrv>; Tue, 14 Jan 2003 10:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbTANPrv>; Tue, 14 Jan 2003 10:47:51 -0500
Received: from mx01.netapp.com ([198.95.226.53]:15070 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id <S264681AbTANPrr> convert rfc822-to-8bit;
	Tue, 14 Jan 2003 10:47:47 -0500
Message-ID: <6440EA1A6AA1D5118C6900902745938E07D551E8@black.eng.netapp.com>
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: =?iso-8859-1?Q?=27Peter_=C5strand=27?= <peter@cendio.se>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: [NFS] Re: broken umount -f
Date: Tue, 14 Jan 2003 07:56:12 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"umount -f" doesn't end pending RPCs.  if there are processes
with pending RPCs, then they are stuck and you will have to
reboot.  "intr" may allow some of these processes to be killed
before trying the "umount."

however, if there are no outstanding RPCs on the client, but
the server is not available, umount -f works as advertised.

> -----Original Message-----
> From: Peter Åstrand [mailto:peter@cendio.se] 
> Sent: Monday, January 13, 2003 4:45 AM
> To: Trond Myklebust
> Cc: nfs@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: [NFS] Re: broken umount -f
> 
> 
> >>For as long as I remember, umount -f has been broken. I got 
> a reminder 
> >>of this fact today when we took an older NFS server out of 
> use. I had 
> >>to reboot almost all machines that had mounts from this server. Not 
> >>nice.
> 
> ...
> 
> > AFAICS It works for me.
> > 
> > Are you using the 'intr' mount option,
> 
> Yes, as often I can. But IMHO, it should be possible to 
> unmount an unreachable NFS fs even if it wasn't mounted with 
> "intr". Otherwise we have a quite silly "sysadmin trap".
> 
> >and are you remembering to kill
> > those processes that are actually using the mount point first?
> 
> One some machines, I killed more or less everything. It 
> didn't help. One some other machines, I couldn't kill so 
> blindly. Remember, both "lsof" and "fuser" hangs.
> 
> Also, as far as I understand, Solaris 8 does not require that 
> you kill all processes before unmounting, if you use the "-f" 
> flag (processes will get EIO). Would it be possible to 
> implement this feature in Linux? That would be really nice.
> 
> Regards, Peter
> 
> 
> >>For as long as I remember, umount -f has been broken. I got 
> a reminder 
> >>of this fact today when we took an older NFS server out of 
> use. I had 
> >>to reboot almost all machines that had mounts from this server. Not 
> >>nice.
> >>
> >>Anyone knows why -f does not work? When I try, I get:
> >>
> >># umount -f /import/applix Cannot MOUNTPROG RPC: RPC: Port mapper 
> >>failure - RPC: Unable to receive umount2: Device or resource busy
> >>umount: /import/applix: device is busy
> >>
> >>lsof and fuser hangs, as do "df" and "du". Really frustrating. It's 
> >>not even possible to cleanly reboot the system, since 
> RedHats shutdown 
> >>scripts wants to unmount NFS fs's.
> >>
> >>I'm not exactly sure I understand what -f is supposed to do. Is it 
> >>correct that it is supposed to unmount without contacting the NFS 
> >>server? I assume that I still have to make sure no 
> processes are using 
> >>the FS? Would it be possible to add a "-9" flag (or something like 
> >>that) that kills off all processes that uses the NFS fs 
> automatically?
> >>
> >>(I'm using all kinds of RedHat Linux versions, from 5.0 up to 7.3. 
> >>From what I can tell, this problems exists in all versions.)
> >>
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by: FREE  SSL Guide from 
> Thawte are you planning your Web Server Security? Click here 
> to get a FREE Thawte SSL guide and find the answers to all 
> your  SSL security issues. 
> http://ads.sourceforge.net/cgi-> bin/redirect.pl?thaw0026en
> 
> 
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/n> fs
> 
