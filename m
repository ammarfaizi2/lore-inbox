Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129720AbRBVVco>; Thu, 22 Feb 2001 16:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129986AbRBVVce>; Thu, 22 Feb 2001 16:32:34 -0500
Received: from 3dyn218.com21.casema.net ([212.64.94.218]:40969 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129720AbRBVVcU>;
	Thu, 22 Feb 2001 16:32:20 -0500
Date: Thu, 22 Feb 2001 23:24:23 +0100
From: bert hubert <ahu@ds9a.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PID generation
Message-ID: <20010222232423.A18448@home.ds9a.nl>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0EEE@ftrs1.intranet.ftr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <27525795B28BD311B28D00500481B7601F0EEE@ftrs1.intranet.ftr.nl>; from f.v.heusden@ftr.nl on Thu, Feb 22, 2001 at 04:35:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 04:35:35PM +0100, Heusden, Folkert van wrote:
> Hi,

Hi Folkert!

> I wrote a patch against 2.2.18 and 2.4.1 to have the kernel generate
> random PIDs. You can find it at http://vanheusden.com/Linux/security.php3
> (amongst other patches). Beware: pretty much experimental and likely to
> make your linux-pc perform like a win95 platform.

Well - I'm not sure that this is a good idea. When PIDs increase
monotonically, chances are very small that the race condition implicit in
sending any signal to a process results in killing the wrong process (ie, a
new process, but with the same PID) - you'd need to zoom through 32000 PIDs
in a very short time to make this happen.

With truly random PIDs, there is a much larger chance of a new process
sitting on a recently used PID.

What would work is to have cryptographically randomly generated PIDs which
would then guarantee not to return a previously returned number within 32000
tries, and also not be predictable - there must be algoritms out there which
do this.

Regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
