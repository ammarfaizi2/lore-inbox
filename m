Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312610AbSDFPCQ>; Sat, 6 Apr 2002 10:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312813AbSDFPCP>; Sat, 6 Apr 2002 10:02:15 -0500
Received: from [194.46.8.33] ([194.46.8.33]:773 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S312610AbSDFPCO>;
	Sat, 6 Apr 2002 10:02:14 -0500
Date: Sat, 6 Apr 2002 16:15:31 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: make install bug?
Message-ID: <20020406151531.GK17144@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building kernels for my servers I have always done this:

	make INSTALL_MOD_PATH=/usr/src/<target-hostname> modules_install

to dump all the modules into an easily tarballable directory 
to be scp'd to the target host.

However for some reason today it's tried to do a depmod on the 
kernel building machine:

make -C  arch/i386/lib modules_install
make[1]: Entering directory `/VNetLinux/linux-2.4.18/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/VNetLinux/linux-2.4.18/arch/i386/lib'
cd /VNetLinux/scout/lib/modules/2.4.18; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b /VNetLinux/scout -r 2.4.18; fi
depmod: *** Unresolved symbols in /VNetLinux/scout/lib/modules/2.4.18/pcmcia/3c575_cb.o
depmod:         pcibios_read_config_byte
depmod:         pcibios_write_config_word
depmod:         pcibios_read_config_dword
depmod:         pcibios_write_config_byte
depmod:         pcibios_write_config_dword
depmod:         pcibios_read_config_word
depmod: *** Unresolved symbols in /VNetLinux/scout/lib/modules/2.4.18/pcmcia/aha152x_cs.o
depmod:         print_msg
depmod:         scsi_command_size
depmod:         scsi_unregister_module
depmod:         scsicam_bios_param
	And so forth....


I'm not sure why this started happening, but it isn't nice
behavior at all. I'd call it a bug as I can't imagine why
I'd want a depmod to occur on the build machine.

Have I managed to tickle something that should not be 
happening?





