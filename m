Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284302AbRLMQHA>; Thu, 13 Dec 2001 11:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbRLMQGv>; Thu, 13 Dec 2001 11:06:51 -0500
Received: from upco.es ([130.206.70.227]:58737 "HELO mail1.upco.es")
	by vger.kernel.org with SMTP id <S284302AbRLMQGl>;
	Thu, 13 Dec 2001 11:06:41 -0500
Date: Thu, 13 Dec 2001 17:06:29 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel@vger.kernel.org
Subject: Re: User-manageable sub-ids proposals
Message-ID: <20011213170629.A16572@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com> <20011212204333.A4017@pimlott.ne.mediaone.net> <3C1873A2.1060702@namesys.com> <20011213113616.B6547@pern.dea.icai.upco.es> <20011213143752.A17124@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213143752.A17124@vestdata.no>; from kernel@ragnark.vestdata.no on Thu, Dec 13, 2001 at 02:37:52PM +0100
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20 - RGtti 2001-01-29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 02:37:52PM +0100, Ragnar Kjørstad wrote:
> On Thu, Dec 13, 2001 at 11:36:16AM +0100, Romano Giannetti wrote:
> > I am romano, uid 300.
> > There is(/are) another(s) user, for example r-slave, uid 3001, no login
> > shell, with home dir in ~romano/r-slave.
> 
> It would be so much nicer to be able to do this on-the-fly, rather than
> having to create the user and it's home directory first.

Yes, this could be nice.

> However, I think one must first start with figguring out what
> functionality we want:
> 1 do we want the "slave" to be able to read the users files

Yes, but _by default_ the slave process could read only the files that you
have world readable (or group readable, if the slave is in the same group
than you, which probably is not a good idea). So you could decide wich file
it can access and which not.

> 2 do we want the "slave" to be able to write the users files

Generally no, but you can create a dir where the slave uid can create file
(think to a java applet that need temporary files, etc...) 

> 3 do we want the "slave" to keep is own configuration files

Define the slave uid to have the same home dir than the main user...

> 
> This should also be possible to implement with minimal impact. All you
> need is a new systemcall to allocate a uid for the slave. This means you
> need to reserve some uids for this purpose, but with 32bit uids......
> 

Yes, but then the slave process is very much _very_ limited. It could need
to read/map dynamic libraries, for example; with my approach the slave uid
processes are processes that have a full-level citizenship and that can do
anything a process can do, but under a different name than the user. Root
uses "nobody" to this extent sometime; my proposal is to extend this to
every (unprivileged) user in a safe way. Then, you can create a chrooted
environment for the new process and tailor the level of access it has
depending on the needs.

                          Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 411 132
