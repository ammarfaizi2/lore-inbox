Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKIG4S>; Thu, 9 Nov 2000 01:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130148AbQKIG4I>; Thu, 9 Nov 2000 01:56:08 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:33832 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129231AbQKIG4C>; Thu, 9 Nov 2000 01:56:02 -0500
Message-ID: <3A0A4A69.6288E1B8@linux.com>
Date: Wed, 08 Nov 2000 22:55:37 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: [bug] usb-uhci locks up on boot half the time
In-Reply-To: <3A09F158.910C925@linux.com> <14857.62696.393621.795132@somanetworks.com> <3A09FD81.E7DA9352@linux.com> <20001108200844.A13446@wirex.com> <3A0A25C1.C46E392B@linux.com> <20001108215901.A13572@wirex.com>
Content-Type: multipart/mixed;
 boundary="------------4A9B2858810B4B7D48DE31CA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4A9B2858810B4B7D48DE31CA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Greg KH wrote:

> On Wed, Nov 08, 2000 at 08:19:13PM -0800, David Ford wrote:
> > I am going thru the steps atm.  The JE driver also hangs.
>
> Thanks for doing this.

np.


> > More information.  I have an external USB 4 port hub, in which I have one
> > logitech mouse at the moment.  I can cold boot and reboot to my heart's
> > delight fine.  But if I unplug/plug in the mouse and reboot, it will hang.
> > Note, I have to unplug and plug back in the mouse to get it recognized by
> > the system before I can use it.
>
> Is the external hub a externally powered hub, or self powered hub (does
> it get it's power from a plug in the wall, or from the USB bus)?  Self
> powered hubs are notoriously flaky and have been known to do evil things
> to the USB bus.

Either.  Currently bus (self) powered.  This hub has worked fine on my other
computers without any adverse affect.

I've stepped through w/ kdb and found some more info.  I'm not experience
enough with kdb to provide more details, my apologies.

usb_uhci():2952
  start_uhci():2896
    pci_write_config_word():

[kdb output trimmed]
pci_write_config_word+0x29:   call   *%eax
pci_conf1_write_config_word:   pushl  %ebp
  +0x1:   movl   %esp,%ebp
  +0x3:   pushl  %esi
  +0x4:   pushl  %ebx
  +0x5:   movl   0x8(%ebp),%edx
  +0x8:   movl   0xc(%ebp),%ecx
  +0xb:   movl   0x10(%ebp),%esi
  +0xe:   movl   0x10(%edx),%eax
  +0x11:   movzbl 0x3c(%eax),%ebx
  +0x15:   movl   0x20(%edx),%eax
  +0x18:   shll   $0x10,%ebx
  +0x1b:   shll   $0x8,%eax
  +0x1e:   movl   $0xcf8,%edx
  +0x23:   orl    $0x80000000,%eax
  +0x28:   orl    %eax,%ebx
  +0x2a:   movl   %ecx,%eax
  +0x2c:   andb   $0xfc,%al
  +0x2e:   orl    %eax,%ebx
  +0x30:   movl   %ebx,%eax
  +0x32:   outl   %eax,(%dx)
  +0x32:   outl   %eax,(%dx)
  +0x33:   movl   %ecx,%edx
  +0x35:   movl   %esi,%eax
  +0x37:   andl   $0x2,%edx
  +0x3a:   orl    $0xcfc,%edx
  +0x40:   outw   %ax,(%dx)

And here is where it hangs.



--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------4A9B2858810B4B7D48DE31CA
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------4A9B2858810B4B7D48DE31CA--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
