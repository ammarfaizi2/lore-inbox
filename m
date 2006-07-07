Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWGGAik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWGGAik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWGGAhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:37:02 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:60355 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751127AbWGGAeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:34:19 -0400
Message-Id: <200607070033.k670XqDv008737@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 16/19] UML - Formatting fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bunch of formatting problems.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/drivers/tty.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/tty.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.17/arch/um/drivers/tty.c	2006-07-06 13:29:48.000000000 -0400
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2001 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -25,17 +25,17 @@ static void *tty_chan_init(char *str, in
 	if(*str != ':'){
 		printk("tty_init : channel type 'tty' must specify "
 		       "a device\n");
-		return(NULL);
+		return NULL;
 	}
 	str++;
 
 	data = um_kmalloc(sizeof(*data));
 	if(data == NULL)
-		return(NULL);
+		return NULL;
 	*data = ((struct tty_chan) { .dev 	= str,
 				     .raw 	= opts->raw });
-				     
-	return(data);
+
+	return data;
 }
 
 static int tty_open(int input, int output, int primary, void *d,
@@ -45,19 +45,21 @@ static int tty_open(int input, int outpu
 	int fd, err;
 
 	fd = os_open_file(data->dev, of_set_rw(OPENFLAGS(), input, output), 0);
-	if(fd < 0) return(fd);
+	if(fd < 0)
+		return fd;
+
 	if(data->raw){
 		CATCH_EINTR(err = tcgetattr(fd, &data->tt));
 		if(err)
-			return(err);
+			return err;
 
 		err = raw(fd);
 		if(err)
-			return(err);
+			return err;
 	}
 
 	*dev_out = data->dev;
-	return(fd);
+	return fd;
 }
 
 struct chan_ops tty_ops = {
@@ -72,14 +74,3 @@ struct chan_ops tty_ops = {
 	.free		= generic_free,
 	.winch		= 0,
 };
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.17/arch/um/drivers/net_user.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/net_user.c	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/net_user.c	2006-07-06 13:29:48.000000000 -0400
@@ -22,13 +22,14 @@ int tap_open_common(void *dev, char *gat
 {
 	int tap_addr[4];
 
-	if(gate_addr == NULL) return(0);
+	if(gate_addr == NULL)
+		return 0;
 	if(sscanf(gate_addr, "%d.%d.%d.%d", &tap_addr[0], 
 		  &tap_addr[1], &tap_addr[2], &tap_addr[3]) != 4){
 		printk("Invalid tap IP address - '%s'\n", gate_addr);
-		return(-EINVAL);
+		return -EINVAL;
 	}
-	return(0);
+	return 0;
 }
 
 void tap_check_ips(char *gate_addr, unsigned char *eth_addr)
@@ -94,10 +95,10 @@ int net_read(int fd, void *buf, int len)
 	n = os_read_file(fd,  buf,  len);
 
 	if(n == -EAGAIN)
-		return(0);
+		return 0;
 	else if(n == 0)
-		return(-ENOTCONN);
-	return(n);
+		return -ENOTCONN;
+	return n;
 }
 
 int net_recvfrom(int fd, void *buf, int len)
@@ -108,11 +109,13 @@ int net_recvfrom(int fd, void *buf, int 
 	      (errno == EINTR)) ;
 
 	if(n < 0){
-		if(errno == EAGAIN) return(0);
-		return(-errno);
+		if(errno == EAGAIN)
+			return 0;
+		return -errno;
 	}
-	else if(n == 0) return(-ENOTCONN);
-	return(n);
+	else if(n == 0)
+		return -ENOTCONN;
+	return n;
 }
 
 int net_write(int fd, void *buf, int len)
@@ -122,10 +125,10 @@ int net_write(int fd, void *buf, int len
 	n = os_write_file(fd, buf, len);
 
 	if(n == -EAGAIN)
-		return(0);
+		return 0;
 	else if(n == 0)
-		return(-ENOTCONN);
-	return(n);
+		return -ENOTCONN;
+	return n;
 }
 
 int net_send(int fd, void *buf, int len)
@@ -134,11 +137,13 @@ int net_send(int fd, void *buf, int len)
 
 	while(((n = send(fd, buf, len, 0)) < 0) && (errno == EINTR)) ;
 	if(n < 0){
-		if(errno == EAGAIN) return(0);
-		return(-errno);
+		if(errno == EAGAIN)
+			return 0;
+		return -errno;
 	}
-	else if(n == 0) return(-ENOTCONN);
-	return(n);	
+	else if(n == 0)
+		return -ENOTCONN;
+	return n;
 }
 
 int net_sendto(int fd, void *buf, int len, void *to, int sock_len)
@@ -148,11 +153,13 @@ int net_sendto(int fd, void *buf, int le
 	while(((n = sendto(fd, buf, len, 0, (struct sockaddr *) to,
 			   sock_len)) < 0) && (errno == EINTR)) ;
 	if(n < 0){
-		if(errno == EAGAIN) return(0);
-		return(-errno);
+		if(errno == EAGAIN)
+			return 0;
+		return -errno;
 	}
-	else if(n == 0) return(-ENOTCONN);
-	return(n);	
+	else if(n == 0)
+		return -ENOTCONN;
+	return n;
 }
 
 struct change_pre_exec_data {
@@ -176,7 +183,7 @@ static int change_tramp(char **argv, cha
 	err = os_pipe(fds, 1, 0);
 	if(err < 0){
 		printk("change_tramp - pipe failed, err = %d\n", -err);
-		return(err);
+		return err;
 	}
 	pe_data.close_me = fds[0];
 	pe_data.stdout = fds[1];
@@ -190,7 +197,7 @@ static int change_tramp(char **argv, cha
 
 	if (pid > 0)
 		CATCH_EINTR(err = waitpid(pid, NULL, 0));
-	return(pid);
+	return pid;
 }
 
 static void change(char *dev, char *what, unsigned char *addr,
@@ -241,26 +248,15 @@ char *split_if_spec(char *str, ...)
 	va_start(ap, str);
 	while((arg = va_arg(ap, char **)) != NULL){
 		if(*str == '\0')
-			return(NULL);
+			return NULL;
 		end = strchr(str, ',');
 		if(end != str)
 			*arg = str;
 		if(end == NULL)
-			return(NULL);
+			return NULL;
 		*end++ = '\0';
 		str = end;
 	}
 	va_end(ap);
-	return(str);
+	return str;
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.17/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/file.c	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/file.c	2006-07-06 13:29:48.000000000 -0400
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -47,11 +47,11 @@ int os_stat_fd(const int fd, struct uml_
 	} while((err < 0) && (errno == EINTR)) ;
 
 	if(err < 0)
-		return(-errno);
+		return -errno;
 
 	if(ubuf != NULL)
 		copy_stat(ubuf, &sbuf);
-	return(err);
+	return err;
 }
 
 int os_stat_file(const char *file_name, struct uml_stat *ubuf)
@@ -64,11 +64,11 @@ int os_stat_file(const char *file_name, 
 	} while((err < 0) && (errno == EINTR)) ;
 
 	if(err < 0)
-		return(-errno);
+		return -errno;
 
 	if(ubuf != NULL)
 		copy_stat(ubuf, &sbuf);
-	return(err);
+	return err;
 }
 
 int os_access(const char* file, int mode)
@@ -80,9 +80,9 @@ int os_access(const char* file, int mode
 
 	err = access(file, amode);
 	if(err < 0)
-		return(-errno);
+		return -errno;
 
-	return(0);
+	return 0;
 }
 
 void os_print_error(int error, const char* str)
@@ -99,9 +99,9 @@ int os_ioctl_generic(int fd, unsigned in
 
 	err = ioctl(fd, cmd, arg);
 	if(err < 0)
-		return(-errno);
+		return -errno;
 
-	return(err);
+	return err;
 }
 
 int os_window_size(int fd, int *rows, int *cols)
@@ -109,12 +109,12 @@ int os_window_size(int fd, int *rows, in
 	struct winsize size;
 
 	if(ioctl(fd, TIOCGWINSZ, &size) < 0)
-		return(-errno);
+		return -errno;
 
 	*rows = size.ws_row;
 	*cols = size.ws_col;
 
-	return(0);
+	return 0;
 }
 
 int os_new_tty_pgrp(int fd, int pid)
@@ -125,16 +125,16 @@ int os_new_tty_pgrp(int fd, int pid)
 	if(tcsetpgrp(fd, pid) < 0)
 		return -errno;
 
-	return(0);
+	return 0;
 }
 
 /* FIXME: ensure namebuf in os_get_if_name is big enough */
 int os_get_ifname(int fd, char* namebuf)
 {
 	if(ioctl(fd, SIOCGIFNAME, namebuf) < 0)
-		return(-errno);
+		return -errno;
 
-	return(0);
+	return 0;
 }
 
 int os_set_slip(int fd)
@@ -149,7 +149,7 @@ int os_set_slip(int fd)
 	if(ioctl(fd, SIOCSIFENCAP, &sencap) < 0)
 		return -errno;
 
-	return(0);
+	return 0;
 }
 
 int os_set_owner(int fd, int pid)
@@ -158,10 +158,10 @@ int os_set_owner(int fd, int pid)
 		int save_errno = errno;
 
 		if(fcntl(fd, F_GETOWN, 0) != pid)
-			return(-save_errno);
+			return -save_errno;
 	}
 
-	return(0);
+	return 0;
 }
 
 /* FIXME? moved wholesale from sigio_user.c to get fcntls out of that file */
@@ -192,9 +192,9 @@ int os_mode_fd(int fd, int mode)
 	} while((err < 0) && (errno==EINTR)) ;
 
 	if(err < 0)
-		return(-errno);
+		return -errno;
 
-	return(0);
+	return 0;
 }
 
 int os_file_type(char *file)
@@ -204,15 +204,21 @@ int os_file_type(char *file)
 
 	err = os_stat_file(file, &buf);
 	if(err < 0)
-		return(err);
+		return err;
 
-	if(S_ISDIR(buf.ust_mode)) return(OS_TYPE_DIR);
-	else if(S_ISLNK(buf.ust_mode)) return(OS_TYPE_SYMLINK);
-	else if(S_ISCHR(buf.ust_mode)) return(OS_TYPE_CHARDEV);
-	else if(S_ISBLK(buf.ust_mode)) return(OS_TYPE_BLOCKDEV);
-	else if(S_ISFIFO(buf.ust_mode)) return(OS_TYPE_FIFO);
-	else if(S_ISSOCK(buf.ust_mode)) return(OS_TYPE_SOCK);
-	else return(OS_TYPE_FILE);
+	if(S_ISDIR(buf.ust_mode))
+		return OS_TYPE_DIR;
+	else if(S_ISLNK(buf.ust_mode))
+		return OS_TYPE_SYMLINK;
+	else if(S_ISCHR(buf.ust_mode))
+		return OS_TYPE_CHARDEV;
+	else if(S_ISBLK(buf.ust_mode))
+		return OS_TYPE_BLOCKDEV;
+	else if(S_ISFIFO(buf.ust_mode))
+		return OS_TYPE_FIFO;
+	else if(S_ISSOCK(buf.ust_mode))
+		return OS_TYPE_SOCK;
+	else return OS_TYPE_FILE;
 }
 
 int os_file_mode(char *file, struct openflags *mode_out)
@@ -302,8 +308,8 @@ int os_seek_file(int fd, __u64 offset)
 
 	actual = lseek64(fd, offset, SEEK_SET);
 	if(actual != offset)
-		return(-errno);
-	return(0);
+		return -errno;
+	return 0;
 }
 
 static int fault_buffer(void *start, int len,
@@ -314,13 +320,13 @@ static int fault_buffer(void *start, int
 
 	for(i = 0; i < len; i += page){
 		if((*copy_proc)(start + i, &c, sizeof(c)))
-			return(-EFAULT);
+			return -EFAULT;
 	}
 	if((len % page) != 0){
 		if((*copy_proc)(start + len - 1, &c, sizeof(c)))
-			return(-EFAULT);
+			return -EFAULT;
 	}
-	return(0);
+	return 0;
 }
 
 static int file_io(int fd, void *buf, int len,
@@ -334,26 +340,26 @@ static int file_io(int fd, void *buf, in
 		if((n < 0) && (errno == EFAULT)){
 			err = fault_buffer(buf, len, copy_user_proc);
 			if(err)
-				return(err);
+				return err;
 			n = (*io_proc)(fd, buf, len);
 		}
 	} while((n < 0) && (errno == EINTR));
 
 	if(n < 0)
-		return(-errno);
-	return(n);
+		return -errno;
+	return n;
 }
 
 int os_read_file(int fd, void *buf, int len)
 {
-	return(file_io(fd, buf, len, (int (*)(int, void *, int)) read,
-		       copy_from_user_proc));
+	return file_io(fd, buf, len, (int (*)(int, void *, int)) read,
+		       copy_from_user_proc);
 }
 
 int os_write_file(int fd, const void *buf, int len)
 {
-	return(file_io(fd, (void *) buf, len,
-		       (int (*)(int, void *, int)) write, copy_to_user_proc));
+	return file_io(fd, (void *) buf, len,
+		       (int (*)(int, void *, int)) write, copy_to_user_proc);
 }
 
 int os_file_size(char *file, unsigned long long *size_out)
@@ -398,11 +404,11 @@ int os_file_modtime(char *file, unsigned
 	err = os_stat_file(file, &buf);
 	if(err < 0){
 		printk("Couldn't stat \"%s\" : err = %d\n", file, -err);
-		return(err);
+		return err;
 	}
 
 	*modtime = buf.ust_mtime;
-	return(0);
+	return 0;
 }
 
 int os_get_exec_close(int fd, int* close_on_exec)
@@ -455,7 +461,7 @@ int os_pipe(int *fds, int stream, int cl
 	if(err < 0)
 		goto error;
 
-	return(0);
+	return 0;
 
  error:
 	printk("os_pipe : Setting FD_CLOEXEC failed, err = %d\n", -err);
@@ -486,12 +492,12 @@ int os_set_fd_async(int fd, int owner)
 	   (fcntl(fd, F_SETOWN, owner) < 0)){
 		err = -errno;
 		printk("os_set_fd_async : Failed to fcntl F_SETOWN "
-		       "(or F_SETSIG) fd %d to pid %d, errno = %d\n", fd, 
+		       "(or F_SETSIG) fd %d to pid %d, errno = %d\n", fd,
 		       owner, errno);
 		return err;
 	}
 
-	return(0);
+	return 0;
 }
 
 int os_clear_fd_async(int fd)
@@ -500,8 +506,8 @@ int os_clear_fd_async(int fd)
 
 	flags &= ~(O_ASYNC | O_NONBLOCK);
 	if(fcntl(fd, F_SETFL, flags) < 0)
-		return(-errno);
-	return(0);
+		return -errno;
+	return 0;
 }
 
 int os_set_fd_block(int fd, int blocking)
@@ -516,7 +522,7 @@ int os_set_fd_block(int fd, int blocking
 	if(fcntl(fd, F_SETFL, flags) < 0)
 		return -errno;
 
-	return(0);
+	return 0;
 }
 
 int os_accept_connection(int fd)
@@ -524,9 +530,9 @@ int os_accept_connection(int fd)
 	int new;
 
 	new = accept(fd, NULL, 0);
-	if(new < 0) 
-		return(-errno);
-	return(new);
+	if(new < 0)
+		return -errno;
+	return new;
 }
 
 #ifndef SHUT_RD
@@ -550,12 +556,12 @@ int os_shutdown_socket(int fd, int r, in
 	else if(w) what = SHUT_WR;
 	else {
 		printk("os_shutdown_socket : neither r or w was set\n");
-		return(-EINVAL);
+		return -EINVAL;
 	}
 	err = shutdown(fd, what);
 	if(err < 0)
-		return(-errno);
-	return(0);
+		return -errno;
+	return 0;
 }
 
 int os_rcv_fd(int fd, int *helper_pid_out)
@@ -578,7 +584,7 @@ int os_rcv_fd(int fd, int *helper_pid_ou
 
 	n = recvmsg(fd, &msg, 0);
 	if(n < 0)
-		return(-errno);
+		return -errno;
 
 	else if(n != sizeof(iov.iov_len))
 		*helper_pid_out = -1;
@@ -586,16 +592,16 @@ int os_rcv_fd(int fd, int *helper_pid_ou
 	cmsg = CMSG_FIRSTHDR(&msg);
 	if(cmsg == NULL){
 		printk("rcv_fd didn't receive anything, error = %d\n", errno);
-		return(-1);
+		return -1;
 	}
-	if((cmsg->cmsg_level != SOL_SOCKET) || 
+	if((cmsg->cmsg_level != SOL_SOCKET) ||
 	   (cmsg->cmsg_type != SCM_RIGHTS)){
 		printk("rcv_fd didn't receive a descriptor\n");
-		return(-1);
+		return -1;
 	}
 
 	new = ((int *) CMSG_DATA(cmsg))[0];
-	return(new);
+	return new;
 }
 
 int os_create_unix_socket(char *file, int len, int close_on_exec)
@@ -623,7 +629,7 @@ int os_create_unix_socket(char *file, in
 	if(err < 0)
 		return -errno;
 
-	return(sock);
+	return sock;
 }
 
 void os_flush_stdout(void)
@@ -654,16 +660,5 @@ int os_lock_file(int fd, int excl)
 	printk("F_SETLK failed, file already locked by pid %d\n", lock.l_pid);
 	err = save;
  out:
-	return(err);
+	return err;
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

