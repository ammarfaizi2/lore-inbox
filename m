Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRCNQ2W>; Wed, 14 Mar 2001 11:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRCNQ2M>; Wed, 14 Mar 2001 11:28:12 -0500
Received: from monza.monza.org ([209.102.105.34]:10259 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131460AbRCNQ2G>;
	Wed, 14 Mar 2001 11:28:06 -0500
Date: Wed, 14 Mar 2001 08:27:10 -0800
From: Tim Wright <timw@splhi.com>
To: John Jasen <jjasen1@umbc.edu>
Cc: linux-kernel@vger.kernel.org, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
Message-ID: <20010314082643.A1044@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: John Jasen <jjasen1@umbc.edu>,
	linux-kernel@vger.kernel.org,
	AmNet Computers <amnet@amnet-comp.com>
In-Reply-To: <3AAF8A71.1C71D517@faceprint.com> <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu>; from jjasen1@umbc.edu on Wed, Mar 14, 2001 at 10:36:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 10:36:40AM -0500, John Jasen wrote:
> 
> The problem:
> 
[ Device name slippage ]
> 
> Possible solutions(?):
> 
> Solaris uses an /etc/path_to_inst file, to keep track of device ordering,
> et al.
> 
> Maybe we should consider something similar, where a physical device to
> logical device map is kept and used to keep things consistent on
> kernel/driver changes; device addition/removal, and so forth ...
> 
> I am, of course, open to better solutions.
> 

This would currently be massive overkill for Linux, but DYNIX/ptx avoids this
problem entirely by keeping a device naming database. This became necessary
when we added support for multi-path fibre-channel connected disks. Most
device-naming conventions rely on "physical" addresses i.e. this disk at the end
of this bus connected to this controller in this PCI slot is /dev/sdd. The
Solaris scheme mentioned above is no different in that respect. Unfortunately,
it doesn't work with multi-path FC-connected devices.

Very briefly, devices that are "id-able" i.e. already have a unique id are
simply entered into the database (SCSI drives have a unique id that you can
read at autoconf time). For elements that are not "id-able", we establish
a derived id by recording their relation to "id-able" elements. At boot time,
we scan (in parallel) the system and compare what we find to the database.
That way, you get consistent naming for devices, and, at least in the case of
the SCSI (or FC) drives, the name doesn't change, even if you pull a drive
from one bus and plug it into a different bus entirely.

As I say, this would be massive overkill for Linux, but it's a rather thorough
solution :-)

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
