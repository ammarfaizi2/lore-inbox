Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRJaV5Q>; Wed, 31 Oct 2001 16:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273870AbRJaV45>; Wed, 31 Oct 2001 16:56:57 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:28823 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S273783AbRJaV4r>;
	Wed, 31 Oct 2001 16:56:47 -0500
Date: Wed, 31 Oct 2001 21:57:21 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Alex Bligh - linux-kernel'" <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: 2xQ: Is PM + ACPI but /no/ APM a valid configuration?
 Interru		pts enabled in APM set power state?
Message-ID: <284303687.1004565440@[195.224.237.69]>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6DC@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6DC@orsmsx111.jf.intel.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

--On Wednesday, 31 October, 2001 1:33 PM -0800 "Grover, Andrew" 
<andrew.grover@intel.com> wrote:

> If you are willing to try acpi, I'd recommend everything on for now.

OK, so I tried the combinations again, and where it says ACPI,
I now mean ACPI + all bells / whistles as suggested. Sadly the net effect
seems to be that it disables any useful power management
functionality, and doesn't fix any broken stuff :-(

Results for T23:

No PM, no ACPI, no APM

suspend works - i.e. doesn't crash on resume,
but 'dumbly' and doesn't restore some PCI states
(unsurprising), clock, etc., and no /proc/apm
etc.

PM, no ACPI, no APM

this seems to work, but debugging the power management
stuff suggests that the PCI drivers are never sent
suspend or resume events, which is causing the
crashes below.

PM, ACPI, no APM

Suspend buttons (all of them) & closing laptop
lid no longer do anything. As there's no apm support,
apm -s doesn't work either, so impossible to test
suspend.

[wierd messages now gone - thanks Andrew.].

PM, no ACPI, APM

Machine hangs on resume.

printk()s tell me that it successfully does
all the pm_send stuff, then calls apm_set_power_state()
(I can see this immediately before the LCD disappears).
But on resume, though the LCD comes back on, it
never gets to the printk() I inserted immediately
afterwards.

I added further printk(s) to immediately after
the segment restore on the bios calls, and indeed
it never appears to return.

PM, ACPI, APM

as above



Also, on advice, I have APM configured to allow
interrupts (IBM laptop). So what happens if a
device interrupts as / because of the resume,
perhaps before the segment registers have
been restored, and certainly before the pm_send
stuff has gone around?

[kernel 2.4.12-ac5 at present]


--
Alex Bligh
