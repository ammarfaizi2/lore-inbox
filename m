Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTBFUds>; Thu, 6 Feb 2003 15:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbTBFUds>; Thu, 6 Feb 2003 15:33:48 -0500
Received: from gw.intrinsity.com ([208.246.32.130]:13278 "HELO
	mailhost.intrinsity.com") by vger.kernel.org with SMTP
	id <S267641AbTBFUdl>; Thu, 6 Feb 2003 15:33:41 -0500
From: <niteowl@intrinsity.com>
Message-Id: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>
Subject: 2.5.59 kernel bugs
To: linux-kernel@vger.kernel.org
Date: Thu, 6 Feb 2003 14:43:17 -0600 (CST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, here's a list of potential 2.5.59 kernel bugs.  Some of these
might be causing real trouble. Many are probably benign.  A few may be
non-bugs that are just poor coding style although I've tried to weed
most of those out of this list.  

The fs/super.c bug is probably the most serious of the bunch as it appears
to completely disable the sync_filesystems() function.

===== dangling else =====
drivers/char/generic_serial.c:152	else

===== misplaced/extra semicolon =====
arch/cris/drivers/eeprom.c:818		if(i2c_getack());
drivers/input/joydev.c:343		for (i = 0; i < joydev->nkey; i++); {
drivers/media/video/w9966.c:745		if(vtune->tuner != 0);
drivers/net/amd8111e.c:956		for( i=0; i< AMD8111E_REG_DUMP_LEN;i+=4);
drivers/net/tokenring/smctr.c:3067	for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++);
drivers/scsi/sym53c8xx_2/sym_hipd.c:237	if (INB (nc_dstat) & ABRT);
drivers/scsi/sym53c8xx.c:6987		if (INB (nc_dstat) & ABRT);
drivers/usb/serial/whiteheat.c:786	if (copy_to_user((unsigned int *)arg, &modem_signals, sizeof(unsigned int)));
fs/super.c:313				if (!sb->s_op->sync_fs);
net/ipv4/fib_hash.c:944			if (iter->zone->fz_next);
sound/oss/cs46xx.c:4317			for(  temp1 = offset; temp1<(offset+count); temp1+=4 );
sound/oss/vidc.c:228			for (new2size = 128; new2size < newsize; new2size <<= 1);
sound/pci/es1968.c:2677			if (val != oval); {

=====  double logical operator =====
drivers/char/ip2/i2lib.c:1254		if ( 1 == i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL) > 0 ) {
drivers/char/ite_gpio.c:143		if (MAX_GPIO_LINE > *data >= 0) 
drivers/char/sx.c:525			for (i=0; i < TIMEOUT_1 > 0;i++) 
drivers/char/sx.c:531			for (i=0; i < TIMEOUT_2 > 0;i++) {
drivers/char/sx.c:551			for (i=0; i < TIMEOUT_1 > 0;i++) 
drivers/char/sx.c:557			for (i=0; i < TIMEOUT_2 > 0;i++) {
drivers/net/fc/iph5526.c:3772		for (i = 0; i < clone_list[i].vendor_id != 0; i++)
drivers/scsi/advansys.c:7103		qdonep->remain_bytes <= scp->request_bufflen != 0) {

===== boolean instead of logical operator =====
fs/hugetlbfs/inode.c:235		if (!super_block | (super_block->s_flags & MS_ACTIVE)) {

===== compare has higher precedence than assignment =====
arch/um/kernel/process.c:125		while((err = waitpid(new_pid, &status, 0) < 0) && (errno == EINTR)) ;
drivers/isdn/hysdn/hysdn_boot.c:146	if ((boot->last_error = card->writebootseq(card, boot->buf.BootBuf, datlen) < 0))
drivers/mtd/nftlmount.c:110		&retlen, buf, (char *)&oob) < 0)) {
drivers/mtd/nftlmount.c:91		8, &retlen, (char *)&h1) < 0)) {
drivers/net/wan/comx-hw-mixcom.c:106	while ((cec = (rd_hscx(dev, HSCX_STAR) & HSCX_CEC) != 0) && 
drivers/pcmcia/i82092.c:154		if ((ret = register_ss_entry(socket_count, &i82092aa_operations) != 0)) {
drivers/scsi/dpt_i2o.c:2540		if((rcode = adpt_i2o_reset_hba(pHba) != 0)){
drivers/scsi/dpt_i2o.c:2566		if((rcode = adpt_i2o_reset_hba(pHba) != 0)){
drivers/scsi/st.c:1953			DEB( debugging = (options & MT_ST_DEBUGGING) != 0; )
fs/jffs/intrep.c:1912			pos) < 0)) {
net/sunrpc/auth_gss/auth_gss.c:686	&bufin, &bufout, &qop_state) < 0))
sound/core/oss/pcm_plugin.c:814		if ((err = snd_pcm_plug_capture_disable_useless_channels(plug, dst_channels, dst_channels_final) < 0))
sound/oss/es1371.c:2857			if ((res=(s->dev_audio = register_sound_dsp(&es1371_audio_fops,-1))<0))
sound/oss/es1371.c:2859			if ((res=(s->codec.dev_mixer = register_sound_mixer(&es1371_mixer_fops, -1)) < 0))
sound/oss/es1371.c:2861			if ((res=(s->dev_dac = register_sound_dsp(&es1371_dac_fops, -1)) < 0))
sound/oss/es1371.c:2863			if ((res=(s->dev_midi = register_sound_midi(&es1371_midi_fops, -1))<0 ))
sound/oss/sscape.c:657			if (hw_config->irq > 15 || (regs[4] = irq_bits == 0xff))
sound/pci/nm256/nm256.c:1542		if ((err = snd_nm256_mixer(chip) < 0))
sound/pci/rme9652/hdsp.c:1579		if ((change = gain != hdsp_read_gain(hdsp, addr)))
sound/pci/rme9652/hdsp.c:1657		if ((change = gain != hdsp_read_gain(hdsp, addr)))
sound/ppc/powermac.c:154		if ((err = snd_pmac_probe() < 0)) {
sound/usb/usbaudio.c:545		if ((err = subs->ops.prepare(subs, substream->runtime, urb) < 0) ||

===== ??? =====
drivers/video/atafb.c:1185		if (par->HDB & 0x200  &&  par->HDB & ~0x200 - par->HDE <= 5) {
sound/oss/nec_vrc5477.c:1142		totalCopyCount =+ copyCount;
